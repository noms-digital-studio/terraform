resource "azurerm_resource_group" "hub-env-testing" {
    name = "hub-env-testing"
    location = "ukwest"
}

resource "azurerm_public_ip" "hub-env-testing-ip" {
  name                         = "hub-env-testing-ip"
  location                     = "ukwest"
  resource_group_name          = "${azurerm_resource_group.hub-env-testing.name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_network_security_group" "hub-env-testing-nsg" {
  name                = "hub-env-testing-nsg"
  location            = "ukwest"
  resource_group_name = "${azurerm_resource_group.hub-env-testing.name}"

}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = "${azurerm_resource_group.hub-env-testing.name}"
  virtual_network_name = "${azurerm_virtual_network.hub-env-testing-vnet.name}"
  address_prefix       = "10.0.3.0/24"
}

resource "azurerm_virtual_network" "hub-env-testing-vnet" {
  name                = "hub-env-testing-vnet"
  resource_group_name = "${azurerm_resource_group.hub-env-testing.name}"
  address_space       = ["10.0.3.0/24"]
  location            = "ukwest"
}

resource "azurerm_network_interface" "hub-env-testing-ni" {
  name                = "hub-env-testing-ni"
  location            = "ukwest"
  resource_group_name = "${azurerm_resource_group.hub-env-testing.name}"

  ip_configuration {
    name                          = "hub-env-testing-ni-ip"
    subnet_id                     = "${azurerm_subnet.default.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.hub-env-testing-ip.id}"
  }
}


resource "azurerm_virtual_machine" "hub-env-testing-vm" {
  name                  = "hub-env-testing-vm"
  location              = "ukwest"
  resource_group_name   = "${azurerm_resource_group.hub-env-testing.name}"
  network_interface_ids = ["${azurerm_network_interface.hub-env-testing-ni.id}"]
  vm_size               = "Standard_A4m_v2"

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "hub-env-testing-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hub-env-testing"
    admin_username = "provisioning"
    admin_password = "ThisIsDisabled111!"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/provisioning/.ssh/authorized_keys"
      key_data = "${file("${path.module}/sshkey.pub")}"
    }
  }
}
