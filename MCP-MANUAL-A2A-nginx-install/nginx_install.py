import subprocess

def simulate_nginx_installation():
    # Simulate system update
    print("Simulating system update...")
    subprocess.run(["apt", "update"], check=True)

    # Simulate Nginx installation
    print("Simulating Nginx installation...")
    subprocess.run(["apt", "install", "-y", "nginx"], check=True)

    # Simulate starting the Nginx service
    print("Simulating starting Nginx...")
    subprocess.run(["systemctl", "start", "nginx"], check=True)

    # Simulate enabling Nginx to start on boot
    print("Simulating enabling Nginx to start on boot...")
    subprocess.run(["systemctl", "enable", "nginx"], check=True)

if __name__ == "__main__":
    simulate_nginx_installation()