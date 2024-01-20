# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/ongoing/hawksight"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "hawksight"; then

  # Create a new wsiindow inline within session layout definition.
  new_window "data"
  run_cmd "cd ./data"
  split_v 70

  new_window "hs-dapp"
  run_cmd "cd ./hs-dapp"
  split_v 70

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
