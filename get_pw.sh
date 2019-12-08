PATH=$PATH:/usr/local/bin
bw login --check &> login_check_file
if [ "You are not logged in." == "$(cat login_check_file)" ];
then
  m_pass=$(security find-generic-password -a 'm' -s 'bw' -w)
  bw login kenzshelley@gmail.com $m_pass --raw
fi

bw unlock --check &> unlock_check_file
if [ "Vault is locked." == "$(cat unlock_check_file)" ];
then
  m_pass=$(security find-generic-password -a 'm' -s 'bw' -w)
  sess=$(bw unlock $m_pass --raw)
  # Update session in keychain
  security delete-generic-password -a 's' -s 'bw' &> /dev/null
  security add-generic-password -a 's' -s 'bw' -p $sess
fi

sess=$(security find-generic-password -a 's' -s 'bw' -w)
pass=$(bw get password $1 --session $sess)

echo $pass
