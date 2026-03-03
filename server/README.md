### Auto install for Dedicated Server with ISO Images

Using ventoy auto install plugin

### Ansible playbook usage
```
ansible-playbook -i hosts.ini ubuntu-playbooks.yaml --ask-pass --ask-become-pass -e "tailscale_authkey="
```