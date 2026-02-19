ARGS=(
    "-f" "docker-compose.yml"
)

for file in "$@"; do
    ARGS+=("-f" "$file")
done

echo "USING FILES: ${ARGS[@]}"
docker compose "${ARGS[@]}" up -d