#!/bin/bash
[ -z "${API_PORT}" ] && API_PORT=3001

curl http://127.0.0.1:${API_PORT}$@
