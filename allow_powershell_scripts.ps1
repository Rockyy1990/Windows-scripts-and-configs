
# Scope: The -Scope parameter in the Set-ExecutionPolicy command can be set
# to CurrentUser , LocalMachine, Process, or User Policy, depending on your needs.

# Set the execution policy to RemoteSigned (allows local scripts to run)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  -Force