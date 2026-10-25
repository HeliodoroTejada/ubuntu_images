#!/usr/bin/env bash

set -euo pipefail
umask 077

runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
target_auth="${runtime_dir}/.mutter-Xwaylandauth.WLL0W3"
session_auth="${XAUTHORITY:-}"
watch_mode=false

if [[ "${1:-}" == "--watch" ]]; then
    watch_mode=true
fi

if [[ -d "${target_auth}" ]]; then
    if ! rmdir -- "${target_auth}"; then
        echo "La ruta Xauthority es un directorio no vacio: ${target_auth}" >&2
        exit 1
    fi
fi

if [[ -e "${target_auth}" && ! -f "${target_auth}" ]]; then
    echo "La ruta Xauthority no es un archivo regular: ${target_auth}" >&2
    exit 1
fi

# Create the bind source before Docker can create a directory in its place.
if [[ ! -e "${target_auth}" ]]; then
    : > "${target_auth}"
fi
chmod 600 "${target_auth}"

shopt -s nullglob

while true; do
    source_auth=""

    if [[ -n "${session_auth}" && "${session_auth}" != "${target_auth}" && -f "${session_auth}" ]]; then
        source_auth="${session_auth}"
    else
        for candidate in "${runtime_dir}"/.mutter-Xwaylandauth.*; do
            [[ -f "${candidate}" && "${candidate}" != "${target_auth}" ]] || continue
            if [[ -z "${source_auth}" || "${candidate}" -nt "${source_auth}" ]]; then
                source_auth="${candidate}"
            fi
        done
    fi

    if [[ -n "${source_auth}" ]]; then
        if ! cmp -s "${source_auth}" "${target_auth}"; then
            # Copy in place so an already-mounted bind file receives new data.
            cp --no-preserve=ownership "${source_auth}" "${target_auth}"
            chmod 600 "${target_auth}"
            echo "Xauthority de ubuntu22_humble actualizado desde ${source_auth}"
        fi

        if [[ "${watch_mode}" == false ]]; then
            exit 0
        fi
    elif [[ "${watch_mode}" == false ]]; then
        echo "No se encontro un archivo Xauthority legible en ${runtime_dir}" >&2
        exit 1
    fi

    sleep 2
done
