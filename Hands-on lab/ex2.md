## Exercise 2: Virtual Network Peering

### Task 1: Configure VNet peering WGVNet1 to WGVNet2 and Vice Versa

1. Select the resource group **WGVNetRG1**, and select the configuration blade for **WGVNet1**. Select **Peerings** under **Settings** on the left.

2. Select **+ Add**.

    ![In this screenshot, the Peerings blade of the WGVNet1 Virtual Network resources is depicted. With the '+ Add' button selected.](images/hol-ex2-task1-add-peerings-button.png "Virtual network blade")

3. Set the following configuration for the new peering. Select **Add** to create the peering.

    **This virtual network**

    - Peering link name: **VNETPeering_WGVNet1-WGVNet2**

    - Traffic to remote virtual network: **Allow (default)**

    - Traffic forwarded from remote virtual network: **Allow (default)**

    - Virtual network gateway or Route Server: **None (default)**

    **Remote virtual network**

    - Peering link name: **VNETPeering_WGVNet2-WGVNet1**

    - Virtual Network: **WGVNet2**

    - Traffic to remote virtual network: **Allow (default)**

    - Traffic forwarded from remote virtual network: **Allow (default)**

    - Virtual network gateway or Route Server: **None (default)**

        ![In this screenshot, the 'Add peering' blade of the Azure portal is depicted with the required settings specified above highlighted for this virtual network.](images/hol-ex2-task1-add-peering-blade-1.png "WGVNet1 add peering blade - this virtual network")

        ![In this screenshot, the 'Add peering' blade of the Azure portal is depicted with the required settings specified above highlighted for this virtual network.](images/hol-ex2-task1-add-peering-blade-2.png "WGVNet1 add peering blade - this virtual network")