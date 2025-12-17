#!/bin/bash

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate odoo-18

# Define paths and database (default values)
ODOO_DIR="/home/okky/Documents/Projek/Odoo/odoo-18-arkana/erajaya/erajaya-odoo"
CONFIG_FILE="$ODOO_DIR/odoo.conf"
DATABASE="odoo_18ee_erajaya"
CUSTOM_ADDONS_PATH="/home/okky/Documents/Projek/Odoo/odoo-18-arkana/erajaya/erajaya-custom-addons"

# Change to Odoo directory
cd "$ODOO_DIR" || exit 1

# Check if config file parameter is provided
HAS_CONFIG_PARAM=false
for arg in "$@"; do
    if [[ "$arg" == "-c" ]] || [[ "$arg" == "--config" ]]; then
        HAS_CONFIG_PARAM=true
        break
    fi
done

# Build command array to properly handle all parameters
CMD_ARGS=()

if [ "$HAS_CONFIG_PARAM" = false ]; then
    # No config parameter provided, add default config first
    echo "Starting Odoo server with default configuration file..."
    CMD_ARGS=(-c "$CONFIG_FILE")
else
    # Config parameter provided, will be included in "$@"
    echo "Starting Odoo server with provided parameters..."
fi

# Add all user-provided parameters
CMD_ARGS+=("$@")

# Run Odoo with all parameters
python odoo-bin "${CMD_ARGS[@]}"

# Print exit message
echo -e "\nOdoo server has been stopped."
