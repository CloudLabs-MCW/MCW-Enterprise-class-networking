## Exercise 1: Create a Virtual Network and provision subnets

### Task 1: Create a Virtual Network

This virtual network will have a gateway subnet named `GatewaySubnet` provisioned with [the guidance from the Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/migrate-best-practices-networking) of using the last part of the virtual network address space.

1. Navigate to the Azure portal. Expand the navigation on the left, then select **+ Create a resource**. In the **Search the Marketplace** box, search for **Virtual network**. Select **Virtual network**, then select **Create**.

2. On the **Create virtual network** blade, on the **Basic** tab, enter the following information:

    - Subscription: **Select your subscription**.

    - Resource group: Select **Create new**, and enter the name **WGVNetRG1**.

    - Name: **WGVNet1**

    - Location: **South Central US**

3. Select **Next: IP Addresses**

    ![In this screenshot, the Basics tab of the 'Create virtual network' blade is depicted with the Resource group, Name, Region, fields and the 'Next: IP Addresses' button highlighted.](images/hol-ex1-task1-create-virtual-network-basics.png "Create virtual network: Basics")

4. On the **Create virtual network - IP Addresses** tab, enter the following information. Then, select **Next: Security**.

    - IPv4 Address space: **10.7.0.0/20**

    - Select **+ Add subnet** then enter the following information and select **Add**.

      - Subnet name: **GatewaySubnet**

      - Subnet address range: **10.7.15.0/27**

5. On the **Create virtual network Security** tab, select **Enable** for **BastionHost**.

6. Enter the following information, then select **Review + Create**.

    - Bastion name: **WGBastion**

    - AzureBastionSubnet address space: **10.7.5.0/24**

    - Public IP address: **Create new**

    - Public IP address name: **BastionPublicIP**

        ![In this screenshot, the 'Security' tab of the Azure portal's 'Create virtual network' blade is depicted with BastionHost, Bastion name, AzureBastionSubnet address space, Public IP address, and 'Review + create' button highlighted.](images/hol-ex1-task1-create-virtual-network-security.png "Create virtual network: Security")

8. Review the configuration and select **Create**.

    ![In this screenshot, the 'Review + create' tab of the Azure portal's 'Create virtual network' blade is depicted' with the 'Create' button highlighted.](images/hol-ex1-task1-create-virtual-network-review.png "Create virtual network: Review + create")

9. Monitor the deployment status by selecting **Notifications** at the top of the portal. When the deployment is complete, select **Go to Resource**.

### Task 2: Configure subnets

1. Go to the WGVNetRG1 Group, and select **WGVNet1** virtual network resource. Once you are on the WGVNet1 virtual network blade, select **Subnets** under **Settings** from the navigation on the left.

    ![In the Virtual Network blade, in the Settings section of the navigation, Subnets is highlighted.](images/hol-ex1-task2-subnets-navigation.png "Virtual Network blade")

2. In the **Subnets** blade select **+Subnet**.

    ![In the Subnets blade for WGVNet1, the add Subnet button is highlighted.](images/hol-ex1-task2-add-subnet-button.png "Subnets blade")

3. On the **Add subnet** blade, enter the following information:

    - Name: **Management**

    - Address range: **10.7.2.0/25**

    - Network security group: **None**

    - Route table: **None**

    - Service Endpoints: **Leave as Default**.

4. When your dialog looks like the following screenshot, select **Save** to create the subnet.

    ![In this screenshot, the 'Add subnet' blade of the Azure portal is depicted with the settings from the previous step as well as the Save button highlighted.](images/hol-ex1-task2-add-subnet-blade-management.png "Add Subnet blade - Management subnet")

5. Repeat Step 3, enter the following information for the Azure Firewall which we will use to control traffic flow in and out of the Network.

    - Name: **AzureFirewallSubnet** (This name is fixed and cannot be changed.)

    - Address range: **10.7.1.0/24**

    - NAT gateway: **None**

    - Network security group: **None**

    - Route table: **None**

    - Service Endpoints: **Leave as Default**

        ![In this screenshot, the 'Add subnet' blade of the Azure portal is depicted with the settings from this step as well as the Save button highlighted.](images/hol-ex1-task2-add-subnet-blade-azure-firewall.png "Add Subnet blade - Azure Firewall subnet")