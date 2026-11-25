export ONECOMPILER_API_KEY=""

curl --request POST "https://api.onecompiler.org/v1/users" \
	--header "Content-Type: application/json" \
	--header "X-API-Key: ${ONECOMPILER_API_KEY}" \
	--data '{
		"name": "",
		"email": "",
		"externalId": "aluno-XX"
		}'


