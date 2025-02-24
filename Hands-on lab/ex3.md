## Exercise 3: Configure Network Security Groups and Application Security Groups

In this exercise, you will restrict traffic between tiers of an n-tier application by using network security groups and application security groups.

### Task 1: Create application security groups

1. In the Azure portal, select **+ Create a resource**. In the **Search the Marketplace** box, search for and select **Application security group**. Next, on the **Application security group** blade, select **Create**.

2. On the **Create an application security group** blade, on the **Basics** tab, enter the following information, and select **Review + create**:

    - Subscription: **Select your subscription**.

    - Resource group: **WGVNetRG2**

    - Name: **WebTier**

    - Region: **South Central US** (This must match the location in which you created the **WGVNet2** virtual network.)

        ![In this screenshot, the 'Create an application security group' blade of the Azure portal is depicted with the above specified settings highlighted.](images/hol-ex3-task1-create-application-security-group-web-tier.png "Create Web Tier ASG")

3. On the **Create an application security group** blade, on the **Review + Create** tab, ensure the validation passes, and select **Create**.

4. Repeat the previous two steps to create an application security group named **DataTier** with the following settings.

    - Subscription: **Select your subscription**.

    - Resource group: **WGVNetRG2**

    - Name: **DataTier**

    - Region: **South Central US** (This must match the location in which you created the **WGVNet2** virtual network.)

        ![In this screenshot, the 'Create an application security group' blade of the Azure portal is depicted with the above specified settings highlighted.](images/hol-ex3-task1-create-application-security-group-data-tier.png "Create Data Tier ASG")

### Task 2: Configure application security groups

1. In the Azure portal, navigate to the **Virtual machines** blade and select **WGWEB1**.

2. On the **WGWEB1** blade, select **Networking** under **Settings** on the left.

3. On the **WGWEB1 - Networking** blade, select **Application security groups** and then select **Configure the application security groups**.

    ![In this screenshot, the networking blade for WGWEB1 is displayed. The Networking navigation option, 'Application security groups' section heading, and 'Configure the application security groups' link are highlighted.](images/hol-ex3-task2-virtual-machine-configure-application-security-groups.png "Networking blade - application security groups section")

4. On the **Configure the application security groups** blade, in the **Application security groups** drop-down list, select **WebTier**, then **Save**.

    ![In this screenshot, the 'Configure the application security groups' blade for WGWEB1 is depicted with the WebTier app security group selected in the 'Application security groups' dropdown and the Save button highlighted.](images/hol-ex3-task2-configure-web-tier-asg.png "Configure Web Tier ASG")

5. Repeat steps 1-4, but this time for **WGWEB2** in order to assign to its network interface the **WebTier** application security group.

6. Repeat steps 1-4, but this time for **WGSQL1** in order to assign to its network interface the **DataTier** application security group.

### Task 3: Create network security group

This task will create a network security group with the following rules:

- Allow SQL traffic (port 1433) from the WebTier application security group to the DataTier application security group.
- Allow HTTP web traffic (port 80) from anywhere to the WebTier application security group.
- Allow RDP traffic (port 3389) from the Azure Bastion range to anywhere.
- Deny all other traffic from the virtual machines to the data tier.
- Deny all other traffic from the virtual machines to the web tier.

1. In the Azure portal, select **+ Create a resource**. In the **Search the Marketplace** box, search for **Network security group** and press Enter. On the **Network security group** blade, select **Create**.

2. On the **Create network security group** blade, enter the following information, and select **Review + Create** then **Create**:

    - Subscription: **Select your subscription**.

    - Resource group: **WGVNetRG2**

    - Name: **WGAppNSG1**

    - Region: **South Central US** (This must match the location in which you created the **WGVNet2** virtual network.)

        ![In this screenshot, the 'Create network security group' blade of the Azure portal is depicted with the required settings listed above highlighted.](images/hol-ex3-task3-create-network-security-group.png "Create WGApp NSG")

3. In the Azure Portal, navigate to **All Services**, type **Network security groups** the search box and select **Network security groups**.

4. On the **Network security groups** blade, select **WGAppNSG1**.

5. On the **WGAppNSG1** blade, select **Inbound security rules** under **Settings** on the left and select **Add**.

    ![In this screen, the 'Inbound security rules' blade for the WGAppNSG1 network security group is displayed. 'Inbound security rules' in the left navigation and the Add button are highlighted.](images/hol-ex3-task3-add-inbound-security-rule.png)

6. On the **Add inbound security rule** blade, enter the following information, and select **Add**:

    - Source: **Application security group**

    - Source application security group: **WebTier**

    - Source port ranges: **\***

    - Destination: **Application security group**

    - Destination application security group: **DataTier**

    - Destination port ranges: **1433**

    - Protocol: **TCP**

    - Action: **Allow**

    - Priority: **100**

    - Name: **AllowDataTierInboundTCP1433**

        ![In this screenshot, the 'Add inbound security rule' blade of the Azure portal is depicted with the above required settings highlighted.](images/hol-ex3-task3-add-inbound-security-rule-data-tier-inbound.png "Configure WGAppNSG1 AllowDataTierInboundTCP1433 rule")

7. On the **WGAppNSG1 - Inbound security rules** blade, select **Add**.

8. On the **Add inbound security rule** blade, enter the following information, and select **Add**:

    - Source: **Any**

    - Source port ranges: **\***

    - Destination: **Application security group**

    - Destination application security group: **WebTier**

    - Destination port ranges: **80**

    - Protocol: **TCP**

    - Action: **Allow**

    - Priority: **150**

    - Name: **AllowAnyWebTierInboundTCP80**

        ![In this screenshot, the 'Add inbound security rule' blade of the Azure portal is depicted with the above required settings highlighted.](images/hol-ex3-task3-add-inbound-security-rule-web-tier-inbound.png "Configure WGAppNSG1 AllowAnyWebTierInboundTCP80 rule")

9. On the **WGAppNSG1 - Inbound security rules** blade, select **Add**.

10. On the **Add inbound security rule** blade, enter the following information, and select **Add**:

    - Source: **IP Addresses**

    - Source IP addresses/CIDR ranges: **10.7.2.0/25, 10.7.5.0/24** (This IP address range represents the Bastion subnet on WGVNet1.)

    - Source port ranges: **\***

    - Destination: **Any**

    - Destination port ranges: **3389**

    - Protocol: **Any**

    - Action: **Allow**

    - Priority: **200**

    - Name: **AllowMgmtInboundAny3389**

        ![In this screenshot, the 'Add inbound security rule' blade of the Azure portal is depicted with the above required settings highlighted.](images/hol-ex3-task3-add-inbound-security-rule-mgmt-inbound.png "Configure WGAppNSG1 AllowMgmtInboundAny3389 rule")

11. On the **WGAppNSG1 - Inbound security rules** blade, select **Add**.

12. On the **Add inbound security rule** blade, enter the following information, and select **Add**:

    - Source: **Service Tag**

    - Source service tag: **VirtualNetwork**

    - Source port ranges: **\***

    - Destination: **Application security group**

    - Destination application security group: **DataTier**

    - Destination port ranges: **\***

    - Protocol: **Any**

    - Action: **Deny**

    - Priority: **1000**

    - Name: **DenyVNetDataTierInbound**

        ![In this screenshot, the 'Add inbound security rule' blade of the Azure portal is depicted with the above required settings highlighted.](images/hol-ex3-task3-add-inbound-security-rule-deny-data-tier-inbound.png "Configure WGAppNSG1 DenyVNetDataTierInbound rule")

13. On the **WGAppNSG1 - Inbound security rules** blade, select **Add**.

14. On the **Add inbound security rule** blade, enter the following information, and select **Add**:

    - Source: **Service Tag**

    - Source service tag: **VirtualNetwork**

    - Source port ranges: **\***

    - Destination: **Application security group**

    - Destination application security group: **WebTier**

    - Destination port ranges: **\***

    - Protocol: **Any**

    - Action: **Deny**

    - Priority: **1050**

    - Name: **DenyVNetWebTierInbound**

        ![In this screenshot, the 'Add inbound security rule' blade of the Azure portal is depicted with the above required settings selected.](images/hol-ex3-task3-add-inbound-security-rule-deny-web-tier-inbound.png "Configure WGAppNSG1 DenyVNetWebTierInbound rule")

15. On the **WGAppNSG1 - Inbound security rules** blade, select **Subnets** under **Settings** and then select **+ Associate**.

    ![In this screenshot, Subnets blade of WGAppNSG1 is depicted. The 'Subnets' navigation and the '+ Associate' button are highlighted.](images/hol-ex3-task3-associate-subnet-nsg.png "WGAppNSG1 Subnets")

16. On the **Associate subnet** blade, select **WGVNet2** on the **Virtual network** drop down and **AppSubnet** on the **Subnet** dropdown.

17. Select **OK** at the bottom of the **Associate subnet** blade.
