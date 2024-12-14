# Remove all the security from Rstudio
echo "Configuring RStudio Server..."
sudo bash -c 'cat << EOF >> /etc/rstudio/rserver.conf
auth-none=1
auth-minimum-user-id=0
server-user=rstudio
EOF'

# Set the default workspacesudo -u rstudio rstudio-server start
echo "Setting default user for R sessions..."
sudo bash -c 'cat << EOF > /etc/rstudio/rsession.conf
session-default-working-dir=/workspaces/lady-penelope
session-default-new-project-dir=/workspaces/lady-penelope
EOF'

# Make the virtual environment.
make venv
