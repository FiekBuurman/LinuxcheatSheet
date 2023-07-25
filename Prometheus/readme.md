
https://github.com/prometheus-pve/prometheus-pve-exporter

Install Docker on the proxmox host
bash <(curl https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Docker/auto_setup_docker_debian.sh)

docker pull prompve/prometheus-pve-exporter
Prometheus PVE Exporter will now be reachable at http://localhost:9221/

<!-- default:
    user: prometheus@pve
    password: kpk84DtNYGwTZFbGkGUKyTTAVAd9rC
    verify_ssl: false -->

default:
    user: prometheus@pve
    token_name: "kpk84DtNYGwTZFbGkGUKyTTAVAd9rC"
    token_value: "f691a892-6e40-45ae-8c1d-d8a32769bd3f"

docker run --name prometheus-pve-exporter -d -p 192.168.2.230:9221:9221 -v /root/prometheus_pve.yml:/etc/pve.yml prompve/prometheus-pve-exporter

docker run --name prometheus-pve-exporter -p 192.168.2.230:9221:9221 -v /root/prometheus_pve.yml:/etc/pve.yml prompve/prometheus-pve-exporter

mkdir -p /etc/prometheus
cat <<EOF > /etc/prometheus/pve.yml
default:
    user: prometheus@pve
    password: kpk84DtNYGwTZFbGkGUKyTTAVAd9rC
    verify_ssl: false
EOF