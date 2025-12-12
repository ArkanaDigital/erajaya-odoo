#!/bin/bash

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate odoo-18

# Define paths and database
ODOO_DIR="/home/okky/Documents/Projek/Odoo/odoo-18-arkana/erajaya/erajaya-odoo"
CONFIG_FILE="$ODOO_DIR/odoo.conf"
DATABASE="odoo_18ee_erajaya"
CUSTOM_ADDONS_PATH="/home/okky/Documents/Projek/Odoo/odoo-18-arkana/erajaya/erajaya-custom-addons"

# Change to Odoo directory
cd "$ODOO_DIR" || exit 1

# Check if addons are provided as command line arguments
if [ $# -eq 0 ]; then
    # No parameters provided, use all addons in the custom addons directory
    echo "No addons specified. Using all addons in $CUSTOM_ADDONS_PATH"
    ADDONS_TO_UPDATE=$(find "$CUSTOM_ADDONS_PATH" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | tr '\n' ',' | sed 's/,$//')
    
    # Check if any addons were found
    if [ -z "$ADDONS_TO_UPDATE" ]; then
        echo "No addons found in $CUSTOM_ADDONS_PATH"
        exit 1
    fi
else
    # Use the provided comma-separated list of addons
    ADDONS_TO_UPDATE=$1
    echo "Using specified addons: $ADDONS_TO_UPDATE"
fi

# Run Odoo update command for the specific addons
echo "Updating addons: $ADDONS_TO_UPDATE"
python odoo-bin -c "$CONFIG_FILE" -d "$DATABASE" --stop-after-init -u "$ADDONS_TO_UPDATE"

# Print completion message
echo -e "\nUpdate process completed. Press any key to exit."
read -n 1 -s
