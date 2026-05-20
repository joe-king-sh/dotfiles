_: {
  # AWS credential_process helper that pulls the long-lived key + MFA from
  # 1Password and caches the STS session back into the same item.
  # Pair with ~/.aws/config: `credential_process = ~/.aws/get-1password-creds.sh`
  home.file.".aws/get-1password-creds.sh" = {
    source = ./get-1password-creds.sh;
    executable = true;
  };
}
