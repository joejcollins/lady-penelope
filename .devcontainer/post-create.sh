# Add the required configuration to /etc/rstudio/rserver.conf
echo "Configuring RStudio Server..."
sudo bash -c 'cat << EOF >> /etc/rstudio/rserver.conf
auth-none=1
auth-minimum-user-id=1000
EOF'

# Make the virtual environment.
make venv
