## Exercise 7: Configure Site-to-Site connectivity

In this exercise, we will simulate an on-premises connection to the internal web application. To do this, we will first set up another Virtual Network in a separate Azure region followed by the Site-to-Site connection of the 2 Virtual Networks Finally, we will set up a virtual machine in the new Virtual Network to simulate on-premises connectivity to the internal load-balancer.

### Task 1: Create OnPrem Virtual Network

1. In the search bar of the Azure portal, type **Virtual network (1)**. From the search results, select **Virtual network (2)**.

    ![](images/lab1vnet2.png)

1. Click on **Create**.

2. On the **Create virtual network** blade, enter the following information:

    - Subscription: **Select your subscription**.

    - Resource group: Select **OnPremVNetRG**.

    - Name: **OnPremVNet**

    - Region: **East US** (Make sure this is **NOT** the same location you have specified in the previous exercises.)

    ![](images/lab7vnet1.png)

3. Leave the other options with their default values.

4. Upon completion, it should look like the following screenshot. Validate the information is correct, and select **Next: IP Addresses**.

    ![In this screenshot, the Basics tab of the 'Create virtual network' blade in the Azure portal is depicted with the required settings selected.](images/hol-ex7-task1-create-virtual-network-onpremvnet.png "Create virtual network")

5. On the **IP addresses** tab of the **Create virtual network blade**, enter the following information.

    - Address space: **192.168.0.0/16**

    - Select **+ Add subnet** then enter the following information in the blade that appears on the right and select **Add**.

      - Subnet name: **default**

      - Subnet address range: **192.168.0.0/24**

    ![](images/lab7vnet2.png)

6. Select **Review + create** then **Create**.

### Task 2: Configure gateway subnets for on premise Virtual Network

1. Select the **OnPremVNetRG** Resource Group and then open the **OnPremVNet** blade and select **Subnets**.

2. Next, select **+ subnet**.

    ![](images/lab7vnet3.png)

3. Specify the following configuration for the subnet, and select **Add**:

    - Subnet Purpose: **Virtual Network Gateway**
    - Starting address: **192.168.1.0**
    - Size: **/27 (32 addresses)**

    ![](images/lab7vnet4.png)

4. Next, select **+ Subnet** and add the **OnPremManagementSubnet** subnet to the **OnPremVNet**, as shown below in the screenshot:

    - Name: **OnPremManagementSubnet**

    - Address range: **192.168.2.0/27**

    - Leave the rest of the values as their defaults. Select **Save**.

        ![In this screenshot, the 'Add subnet' blade of the Azure portal is depicted with the required settings listed above selected along with the Save button.](images/a1.5.png "Add subnet")

### Task 3: Create the first gateway

1. In the search bar of the Azure portal, type **Virtual network gateway (1)**. From the search results, select **Virtual network gateway (2)**.

    ![](images/lab7vnet5.png)

2. On the **Create virtual network gateway** blade,  enter the following information and select **Review + create**:

    - Subscription: **Select your subscription**.

    - Name: **OnPremWGGateway**

    - Region: **East US** (This must match the location in which you created the **OnPremVNet** virtual network.)

    - Gateway type: **VPN**

    - SKU: **VpnGw1**

    - Virtual network: **OnPremVNet**

    - Public IP address: **Create new**

    - Public IP address name: **onpremgatewayIP1**

    - Enable active-active mode: **Enabled**

    - Second Public IP address name: **onpremgatewayIP2**

    - Configure BGP: **Disabled**

    ![](images/lab7vnet6.png)
    ![](images/lab7vnet7.png)

3. Validate your settings and select **Review + Create** then **Create**.

    >**Note:** The gateway will take 30-45 minutes to provision. Rather than waiting, continue to the next task.

### Task 4: Create the second gateway

1. In the search bar of the Azure portal, type **Virtual network gateway (1)**. From the search results, select **Virtual network gateway (2)**.

    ![](images/lab7vnet5.png)

2. On the **Create virtual network gateway** blade,  enter the following information and select **Review + create**:

    - Subscription: **Select your subscription**.

    - Name: **WGVNet1Gateway**

    - Region: **South Central US** (This must match the location in which you created the **WGVNet1** virtual network.)

    - Gateway type: **VPN**

    - SKU: **VpnGw1**

    - Virtual network: **WGVNet1**

    - Resource group: **WGVNetRG1**

    - Public IP address: **Create new**

    - Public IP address name: **vnet1gatewayIP1**

    - Enable active-active mode: **Enabled**

    - Second Public IP address name: **vnet1gatewayIP2**

    - Configure BGP: **Disabled**

    ![](images/lab7vnet8.png)
    ![](images/lab7vnet9.png)

3. Validate your settings and select **Review + Create** then **Create**.

    >**Note:** The gateway will take 30-45 minutes to provision. You will need to wait until both gateways are provisioned before proceeding to the next section.

4. The Azure portal will display a notification when the deployments have completed.

### Task 5: Connect the gateways

1. In the Azure portal, in the 'Search resources, services, and docs' search box, type **connections** in the search text box. Select **Connections**.

    ![In this screenshot, the 'Search resources, services, and docs' search box of the Azure portal is depicted with Connections searched for and selected.](images/hol-ex7-task5-search-for-connections.png "Azure Portal")

2. Click on **Create**.

2. On the **Connection** blade, select **Create**.

3. On the **Basics** blade, leave the **Connection type** set to **VNet-to-VNet**. Select the existing **WGVNetRG1** resource group. Enter the following information and select **Next: Settings**:
    - Establish bidirectional connectivity - checked
    - First connection name - **WGVNet1-to-OnPremWGGateway**
    - Second connection name - **WGGateway-to-WGVNet1**
    - Region - **South Central US**

        ![In this screenshot, the Basics step of the 'xCreate connection' blade of the Azure portal is depicted with the required settings listed above selected.](images/hol-ex7-task5-create-connection-vnet-to-vnet.png "Basics")

4. On the Settings step, select **WGVNet1Gateway** as the first virtual network gateway and **OnPremWGGateway** as the second virtual network gateway. Ensure **Establish bidirectional connectivity** and **IKEv2** is selected. Enter a shared key, such as **A1B2C3D4**. Select **Review + create**.

    ![In this screenshot, the Settings step of the 'Create connection' blade of the Azure portal is depicted with the required settings listed above selected including the two virtual network gateway resources created earlier.](images/hol-ex7-task5-create-connection-vnet-to-vnet-settings.png "select virtual network gateway")

5. Select **Create** on the **Summary** page to create the connection.

6. In the Azure portal, in the 'Search resources, services, and docs' search box, type **connections** in the search text box. Select **Connections**.

    ![In this screenshot, the 'Search resources, services, and docs' search box of the Azure portal is depicted with Connections searched for and selected.](images/hol-ex7-task5-search-for-connections.png "Azure Portal")

7. Watch the progress of the connection status, and use the **Refresh** icon until the status changes for both connections from **Unknown** to **Connected**. This may take 5-10 minutes or more. You might need to refresh the page to see the change in status.

    ![In this screenshot, the Connections blade of the Azure portal is depicted with the two connections created earlier listed with their respective statuses showing as Connected.](images/hol-ex7-task5-connections-blade.png "Connections blade")

### Task 6: Update VNet peerings to use gateway

1. In the Azure Portal, go to All Services and type **virtual network** in the search box and select **Virtual Networks**.

2. Select **WGVNet1**, and select **Peerings** under **Settings** on the left.

    ![](images/lab7vnet10.png)

3. On the **Peerings** pane, select the **VNETPeering_WGVNet1-WGVNet2** peering.

    ![](images/lab7vnet11.png)

4. On the **VNETPeering_WGVNet1-WGVNet2**, set the **Virtual network gateway or Route Server** setting to the value of **Use this virtual network's gateway or Route Server**.

    ![Peering settings pane with virtual network gateway setting configured.](images/hol-ex7-task6-wgvnet1-peering-configured.png "Peering settings")

5. Select **Save**.

6. In the Azure Portal, go to All Services and type **virtual network** in the search box and select **Virtual Networks**.

7. Select **WGVNet2**, and select **Peerings** under **Settings** on the left.

    ![In the Virtual Network blade, in the Settings section of the navigation, Peerings is highlighted.](images/hol-ex7-task6-wgvnet2-peerings.png "Virtual network blade")

8. On the **Peerings** pane, select the **VNETPeering_WGVNet2-WGVNet1** peering.

    ![Peerings pane showing the virtual network peering that is configured.](images/hol-ex7-task6-wgvnet2-peerings-list.png "Peerings list")

9. On the **VNETPeering_WGVNet2-WGVNet1**, set the **Virtual network gateway or Route Server** setting to the value of **Use the remote virtual network's gateway or Route Server**.

    ![Peering settings pane with virtual network gateway setting configured.](images/hol-ex7-task6-wgvnet2-peering-configured.png "Peering settings")

10. Select **Save**.

The change to the gateway setting for the virtual network peerings may take a few minutes to update.
