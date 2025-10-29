#!/usr/bin/env bash
set -e

read -r input
fqdn=$(echo "$input" | jq -r '.fqdn')
expected_ipv4=$(echo "$input" | jq -r '.expected_ipv4')
expected_ipv6=$(echo "$input" | jq -r '.expected_ipv6')

check_dns() {
  local record_type=$1
  local expected=$2
  dig +short "$fqdn" "$record_type" | grep -F "$expected" >/dev/null 2>&1
}

echo "Waiting for DNS propagation for $fqdn"
[[ -n "$expected_ipv4" ]] && echo "  Expecting IPv4: $expected_ipv4"
[[ -n "$expected_ipv6" ]] && echo "  Expecting IPv6: $expected_ipv6"

# Edge case: nothing to wait for
if [[ -z "$expected_ipv4" && -z "$expected_ipv6" ]]; then
  echo "No expected IPs provided, skipping wait."
  jq -n --arg status "skipped" '{"status":$status}'
  exit 0
fi

for i in {1..30}; do
  ok4=true
  ok6=true

  if [[ -n "$expected_ipv4" ]]; then
    check_dns "A" "$expected_ipv4" && ok4=true || ok4=false
  fi

  if [[ -n "$expected_ipv6" ]]; then
    check_dns "AAAA" "$expected_ipv6" && ok6=true || ok6=false
  fi

  if [[ "$ok4" == "true" && "$ok6" == "true" ]]; then
    jq -n --arg status "ok" '{"status":$status}'
    echo "✅ DNS propagated successfully."
    exit 0
  fi

  echo "Waiting... (IPv4: $ok4, IPv6: $ok6)"
  sleep 10
done

jq -n --arg status "timeout" '{"status":$status}'
echo "❌ Timeout waiting for DNS propagation."
exit 1
