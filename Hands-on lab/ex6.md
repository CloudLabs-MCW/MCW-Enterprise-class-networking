## Exercise 6: Provision and configure Azure firewall solution

In this exercise, you will provision and configure an Azure firewall in your network.

## Lab objectives

In this lab, you will perform following tasks:

- Provision the Azure firewall
- Create Firewall Rules
- Associate route tables to subnets
  
## Estimated timing: 60 minutes

### Task 1: Provision the Azure firewall

1. In the search bar of the Azure portal, type **Load balancers (1)**. From the search results, select **Load balancers (2)**.

    ![](images/lab6fire1.png)

2. On the **Create a firewall** blade, on the **Basics** tab, enter the following information:

    | Setting | Action |
    | -- | -- |
    | Subscription | Select your subscription |
    | Resource group | **WGVNetRG1** |
    | Name | **azureFirewall** |
    | Region | **South Central US** |
    | Firewall SKU | **Standard** |
    | Firewall management | **Use Firewall rules (classic) to manage this Firewall** |
    | Choose a Virtual network | **Use existing** |
    | Virtual network | **WGVNet1** |
    | Public IP address | **(Add new) azureFirewall-ip** |
    | Enable Firewall Management NIC | **UNCHECKED** |

    ![](images/hol-ex6-task1-create-a-firewall-wgvnetrg1.png)
    ![](images/lab6fire2.png)

3. Select **Review + create** and then select **Create** to provision the Azure Firewall.

### Task 2: Create Firewall Rules

Within 1-2 minutes, the resource group **WGVNetRG1** will have the firewall created. Next, we will create firewall rules to allow the inbound and outbound traffic.

1. On the main Azure menu, select **Resource groups**.

2. Select the **WGVNetRG1** resource group. This resource group contains the azure firewall and its public IP address resources.

3. Navigate to the **azureFirewall-ip** blade and note the value of its public IP address. You will need it later in this task.

    ![](images/lab6fire3.png)

4. Navigate to the **azureFirewall** blade, and, on the **Overview** page, select **Rules (classic)** under **Settings** on the left.

    ![](images/lab6fire4.png)

5. Select **+ Add NAT Rule collection** and enter the following information to create an inbound NAT Rule (a collection is a list of rules that share the same priority and action) then select **Add**:

    | Setting | Action |
    | -- | -- |
    | Name | **NATRuleCollection1** |
    | Priority | **250** |
    | Rules name | **IncomingHTTP** |
    | Protocol | **TCP** |
    | Source type | **IP Address** |
    | Source| **\*** |
    | Destination Address | Type the public IP address assigned to the firewall you identified earlier in this task|
    | Destination ports | **80** (to allow HTTP traffic) |
    | Translated Address | **10.8.0.100** (Private IP of the Azure Load Balancer you deployed earlier in this lab.) |
    | Translated Port | Translated Port: **80** |

    ![](images/lab6fire5.png)
    ![](images/lab6fire6.png)

6. Back on the **azureFirewall - Rules (classic)** page, select the newly created NAT rule collection. Add another rule for HTTPS, as illustrated in the following screenshot (alternatively you could create a single rule for both HTTP and HTTPS). The rules should look like the image below.

    | Setting | Action |
    | -- | -- |
    | Rules name | **IncomingHTTPS** |
    | Protocol | **TCP** |
    | Source type | **IP Address** |
    | Source | **\*** |
    | Destination Address | Type the public IP address assigned to the firewall you identified earlier in this task. |
    | Destination ports | **443** |
    | Translated Address | **10.8.0.100** |
    | Translated Port | **443** |
  
    ![In this screenshot, the 'Edit NAT rule collection' page is depicted with the required settings listed above selected.](images/hol-ex6-task2-edit-nat-rule-collection.png "Azure Firewall NAT Rules for HTTP and HTTPS")

    ![](images/lab6fire7.png)

7. Select **Save** and wait until the update completes.

8. Back on the Azure Firewall **Rules (classic)** page, select **Network rule collection**. Then Select **+ Add Network Rule collection** and enter the following information to create a Network Rule for inbound traffic. This rule allows HTTP connectivity from any directly connected network targeting the frontend IP address of the load balancer.

    | Setting | Action |
    | -- | -- |
    | Name | **NetworkRuleCollectionAllow1** |
    | Priority | **100** |
    | Action | **Allow** |
    | Rules name (IP Addresses) | **IncomingWeb** |
    | Protocol | **TCP** |
    | Source| **\*** |
    | Destination Address | **10.8.0.100** |
    | Destination ports | **80,443** |

    ![In this screenshot, the azureFirewall Rules (classic) blade is depicted. The 'Network rule collection' tab and the 'Add network rule collection' link are highlighted.](images/hol-ex6-task2-network-rule-collection.png)

    ![](images/lab6fire8.png)

9. Create another rule for Remote Desktop sessions from the Management subnet on WGVNet1. The IP Addresses rules should look like the image below.

    | Setting | Action |
    | -- | -- |
    | Rules name (IP Addresses) | **IncomingMgmtRDP** |
    | Protocol | **TCP** |
    | Source| **10.7.2.0/25** |
    | Destination Address | **10.8.0.0/25** |
    | Destination ports | **3389** |

    ![In this screenshot, the 'IP Addresses' section of the 'Add network rule collection' blade of the Azure portal is depicted with the required settings listed above selected.](images/hol-ex6-task2-add-network-rule-mgmt-subnet.png "Azure Firewall IP Addresses section")

10. Select **Add** and wait until the update completes.

### Task 3: Associate route tables to subnets

1. In the Azure portal, navigate to the blade of the **WGVNetRG2** resource group.

2. Select **AppRT**, followed by **Subnets** and then select **+ Associate**.

    ![In this screenshot, the AppRT - Subnets blade is depicted with Subnets selected on the left and the '+ Associate' button selected.](images/hol-ex6-task3-route-table-associate-button.png "AppRT Route table blade")

3. On the **Associate subnet** blade, select **WGVNet2** on the **Virtual network** drop down. Select **AppSubnet** on the **Subnet** dropdown.

    ![In this screenshot, the 'Associate subnet' blade is depicted with the 'WGVNet2' virtual network and 'AppSubnet' subnet selected along with the 'OK' button.](images/hol-ex6-task3-associate-subnet-blade-wgvnet2.png "Associate subnet section for AppRT")

4. Select **OK** at the bottom of the **Associate subnet** blade.

5. Navigate to the blade of the **WGVNetRG1** resource group, and select **MgmtRT**, then **Subnets**.

6. Select **+ Associate**.

7. On the **Associate subnet** blade, select **WGVNet1** on the **Virtual network** drop down. Select **Management** on the **Subnet** dropdown.

    ![In this screenshot, the 'Associate subnet' blade is depicted with the 'WGVNet1' virtual network and 'Management' subnet selected along with the 'OK' button.](images/hol-ex6-task3-associate-subnet-blade-wgvnet1.png "Associate subnet blade for MgmtRT")

8. Select **OK** at the bottom of the **Associate subnet** blade.

### Review
In this lab, you have completed:
- Provisioned the Azure firewall
- Created Firewall Rules
- Associated route tables to subnets

## Great job on completing this exercise! You can now proceed to the next one.
