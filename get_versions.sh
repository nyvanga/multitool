#!/bin/bash

shopt -s extglob

K8S_RELEASES_URL="https://kubernetes.io/releases/"
TF_RELEASES_URL="https://releases.hashicorp.com/terraform/"

MAJOR_VERSIONS=()
UNIQ_MAJOR_VERSIONS=()
VERSIONS=()
STABLE_VERSIONS=()

function usage() {
	echo "Usage: $(basename $0) <kubernetes|terraform> <all|major|stable|latest|major version>"
	echo "All:"
	echo "  Lists all versions."
	echo "Major:"
	echo "  Lists latest of each major version."
	if [[ ${#STABLE_VERSIONS[@]} -gt 0 ]]; then
		echo "Stable is:"
		echo "  $(echo ${STABLE_VERSIONS[0]})"
	fi
	if [[ ${#VERSIONS[@]} -gt 0 ]]; then
		echo "Latest is:"
		echo "  $(echo ${VERSIONS[0]})"
	fi
	if [[ ${#UNIQ_MAJOR_VERSIONS[@]} -gt 0 ]]; then
		echo "Major version one of:"
		echo "  $(echo ${VERSION_PATTERN} | sed -r 's/\|/, /g')"
	fi
	exit 1
}

function get_versions() {
	local previous_major_version=""
	for index in ${!VERSIONS[@]}; do
		local major_version=$(echo "${VERSIONS[index]}" | sed -r 's/^([0-9]+\.[0-9]+).*$/\1/')
		MAJOR_VERSIONS+=("${major_version}")
		if [[ "${major_version}" != "${previous_major_version}" ]]; then
			previous_major_version=${major_version}
			UNIQ_MAJOR_VERSIONS+=("${major_version}")
		fi
		VERSIONS+=("${VERSIONS[index]}")
		if [[ ! ${VERSIONS[index]} =~ (alpha|beta|oci|rc) ]]; then
			STABLE_VERSIONS+=("${VERSIONS[index]}")
		fi
	done
	VERSION_PATTERN="$(echo ${UNIQ_MAJOR_VERSIONS[@]} | sed 's/ /\|/g')"
}

function get_k8s_versions() {
	while read -r version_line
	do
		VERSIONS+=("$(echo "${version_line}" | sed -r 's/^.*Latest Release:[^0-9]+([.0-9]+).*$/\1/')")
	done < <(curl -sS ${K8S_RELEASES_URL} | egrep 'Latest Release:')
	get_versions
}

function get_tf_versions() {
	while read -r version_line
	do
		VERSIONS+=("$(echo "${version_line}" | sed -r 's/^.*\/terraform\/([^\/"]+)(\/|").*$/\1/')")
	done < <(curl -sS ${TF_RELEASES_URL} | egrep '<a href="/terraform/')
	get_versions
}

function get_version() {
	local index=$1; shift
	local extra_tags=""
	if [[ "${VERSIONS[index]}" == "${STABLE_VERSIONS[0]}" ]]; then
		extra_tags="${extra_tags} stable"
	fi
	if [[ "${VERSIONS[index]}" == "${VERSIONS[0]}" ]]; then
		extra_tags="${extra_tags} latest"
	fi
	echo "${MAJOR_VERSIONS[index]} ${VERSIONS[index]}${extra_tags}"
}

function get_major_version() {
	local major_version=$1; shift
	for index in ${!MAJOR_VERSIONS[@]}; do
		if [[ "${major_version}" == "${MAJOR_VERSIONS[index]}" ]]; then
			get_version ${index}
			return
		fi
	done
}

function get_github_actions_version() {
	local major_version_index=$1; shift
	local major_version=${UNIQ_MAJOR_VERSIONS[index]}
	for index in ${!MAJOR_VERSIONS[@]}; do
		if [[ "${major_version}" == "${MAJOR_VERSIONS[index]}" ]]; then
			echo "::set-output name=major${major_version_index}::${major_version}"
			echo "::set-output name=minor${major_version_index}::${VERSIONS[index]}"
			return
		fi
	done
}

function version_command() {
	case "$1" in
		all)
			for index in ${!VERSIONS[@]}; do
				get_version ${index}
			done
			;;

		major)
			for index in ${!UNIQ_MAJOR_VERSIONS[@]}; do
				get_major_version ${UNIQ_MAJOR_VERSIONS[index]}
			done
			;;

		stable)
			echo ${STABLE_VERSIONS[0]}
			;;

		latest)
			echo ${VERSIONS[0]}
			;;

		@($VERSION_PATTERN))
			get_major_version $1
			;;

		github_actions)
			for index in 0 1 2; do
				get_github_actions_version ${index}
			done
			;;

		*)
			usage
			;;
	esac
}

TYPE="${1}"; shift
case "${TYPE}" in
	kubernetes)
		get_k8s_versions
		version_command "$@"
		;;

	terraform)
		get_tf_versions
		version_command "$@"
		;;

	*)
		usage
		;;
esac