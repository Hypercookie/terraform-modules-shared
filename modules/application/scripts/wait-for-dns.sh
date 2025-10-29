#!/usr/bin/env bash
set -eo pipefail

# Read JSON input from Terraform
read -r input
fqdn=$(echo "$input" | jq -r '.fqdn')
expected_ipv4=$(echo "$input" | jq -r '.expected_ipv4')
expected_ipv6=$(echo "$input" | jq -r '.expected_ipv6')

check_dns() {
  local record_type=$1
  local expected=$2

  # Return 0 if found, 1 if not found
  if dig +short "$fqdn" "$record_type" | grep -Fq "$expected"; then
    return 0
  else
    return 1
  fi
}

# Print error JSON and exit gracefully
fail_json() {
  local msg=$1
  jq -n --arg status "error" --arg message "$msg" '{"status":$status,"message":$message}'
  echo "❌ $msg" >&2
  exit 0
}

echo "🔍 Waiting for DNS propagation for $fqdn"
[[ -n "$expected_ipv4" ]] && echo "  Expecting IPv4: $expected_ipv4"
[[ -n "$expected_ipv6" ]] && echo "  Expecting IPv6: $expected_ipv6"

# Edge case: nothing to wait for
if [[ -z "$expected_ipv4" && -z "$expected_ipv6" ]]; then
  jq -n --arg status "skipped" '{"status":$status}'
  echo "ℹ️ No expected IPs provided, skipping wait."
  exit 0
fi

for i in {1..30}; do
  ok4=true
  ok6=true

  if [[ -n "$expected_ipv4" ]]; then
    if check_dns "A" "$expected_ipv4"; then
      ok4=true
    else
      ok4=false
    fi
  fi

  if [[ -n "$expected_ipv6" ]]; then
    if check_dns "AAAA" "$expected_ipv6"; then
      ok6=true
    else
      ok6=false
    fi
  fi

  if [[ "$ok4" == "true" && "$ok6" == "true" ]]; then
    jq -n --arg status "ok" '{"status":$status}'
    echo "✅ DNS propagated successfully."
    exit 0
  fi

  echo "⏳ Waiting... (IPv4: $ok4, IPv6: $ok6)"
  sleep 10
done

# Timed out — emit JSON but do not fail Terraform
jq -n --arg status "timeout" '{"status":$status}'
echo "❌ Timeout waiting for DNS propagation."
exit 0
