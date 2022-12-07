#     ____ _ _   _   _       _       _____     _              
#    / ___(_) |_| | | |_   _| |__   |_   _|__ | | _____ _ __  
#   | |  _| | __| |_| | | | | '_ \    | |/ _ \| |/ / _ \ '_ \ 
#   | |_| | | |_|  _  | |_| | |_) |   | | (_) |   <  __/ | | |
#    \____|_|\__|_| |_|\__,_|_.__/    |_|\___/|_|\_\___|_| |_|
#                                                             

# Magic required to be able to save our changes to GitHub using tokens

# Step 0
#
# Check which remote we are connected to
usethis::git_remotes()

# Step 1
#
# Create a new Personal Access Token (PAT)
usethis::create_github_token(scopes = 'repo', description = 'R Workshop')

# Step 2
#
# Save our Personal Access Token (PAT)
gitcreds::gitcreds_set(url = "https://github.com")
