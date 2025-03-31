# Remove all the security from Rstudio
echo "Configuring RStudio Server..."
sudo bash -c 'cat << EOF >> /etc/rstudio/rserver.conf
auth-none=1
auth-minimum-user-id=0
server-user=rstudio
EOF'

# Set the log level for Rstudio
sudo sed -i 's/^log-level=.*$/log-level=info/' /etc/rstudio/logging.conf

# Set the default workspaces
echo "Setting default user for R sessions..."
sudo bash -c 'cat << EOF > /etc/rstudio/rsession.conf
session-default-working-dir=/workspaces/lady-penelope
session-default-new-project-dir=/workspaces/lady-penelope
EOF'
