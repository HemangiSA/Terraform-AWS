###############################################################################
# Create a Virtual Private Cloud (VPC)
# A VPC is a logically isolated virtual network in AWS.
###############################################################################
resource "aws_vpc" "VPCTerraform01July2026" {

  # Defines the IP address range for the VPC.
  # CIDR /16 provides 65,536 private IP addresses.
  cidr_block = var.aws_vpc_cidr

  # Tags help identify the resource in the AWS Console.
  tags = {

    # Name tag displayed in AWS Console.
    Name = "VPCTerraform01July2026"
  }
}

###############################################################################
# Create Public Subnet
# Resources inside this subnet can access the internet.
###############################################################################
resource "aws_subnet" "PublicSubnetTerraform01July2026" {

  # Specifies which VPC this subnet belongs to.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  # IP address range for this subnet.
  cidr_block = "10.6.1.0/24"

  # AWS Availability Zone.
  availability_zone = "us-east-1a"

  # Resource Tags.
  tags = {
    Name = "PublicSubnetTerraform01July2026"
  }
}

###############################################################################
# Create Private Subnet
# Resources inside this subnet are not directly accessible from the Internet.
###############################################################################
resource "aws_subnet" "PrivateSubnetTerraform01July2026" {

  # Attach subnet to the VPC.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  # CIDR block for the private subnet.
  cidr_block = "10.6.2.0/24"

  # Availability Zone.
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnetTerraform01July2026"
  }
}

###############################################################################
# Create Public Route Table
# A Route Table determines where network traffic is routed.
###############################################################################
resource "aws_route_table" "PublicRouteTableTerraform01July2026" {

  # Associate this Route Table with the VPC.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  tags = {
    Name = "PublicRouteTableTerraform01July2026"
  }

  ###########################################################################
  # Default Route
  # Route all Internet traffic to the Internet Gateway.
  ###########################################################################
  route {

    # 0.0.0.0/0 means all IPv4 addresses.
    cidr_block = "0.0.0.0/0"

    # Internet Gateway used to access the Internet.
    gateway_id = aws_internet_gateway.InternetGatewayTerraform01July2026.id
  }
}

###############################################################################
# Associate Public Route Table with Public Subnet
###############################################################################
resource "aws_route_table_association" "PublicRouteTableAssociationTerraform01July2026" {

  # Public Subnet ID.
  subnet_id = aws_subnet.PublicSubnetTerraform01July2026.id

  # Public Route Table ID.
  route_table_id = aws_route_table.PublicRouteTableTerraform01July2026.id
}

###############################################################################
# Create Private Route Table
###############################################################################
resource "aws_route_table" "PrivateRouteTableTerraform01July2026" {

  # Attach Route Table to the VPC.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  tags = {
    Name = "PrivateRouteTableTerraform01July2026"
  }
}

###############################################################################
# Associate Private Route Table with Private Subnet
###############################################################################
resource "aws_route_table_association" "PrivateRouteTableAssociationTerraform01July2026" {

  # Private Subnet ID.
  subnet_id = aws_subnet.PrivateSubnetTerraform01July2026.id

  # Private Route Table ID.
  route_table_id = aws_route_table.PrivateRouteTableTerraform01July2026.id
}

###############################################################################
# Create Internet Gateway
# Internet Gateway allows communication between the VPC and the Internet.
###############################################################################
resource "aws_internet_gateway" "InternetGatewayTerraform01July2026" {

  # Attach Internet Gateway to the VPC.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  tags = {
    Name = "InternetGatewayTerraform01July2026"
  }
}

###############################################################################
# Launch EC2 Instance
###############################################################################
resource "aws_instance" "ec2" {

  # Amazon Machine Image (Operating System).
  ami = "ami-0b6d9d3d33ba97d99"

  # EC2 Instance Type.
  instance_type = "t3.micro"

  # Launch EC2 inside the Public Subnet.
  subnet_id = aws_subnet.PublicSubnetTerraform01July2026.id

  # Assign a Public IP automatically.
  associate_public_ip_address = true

  # Attach Security Group to EC2.
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  tags = {

    # Name shown in AWS Console.
    Name = "EC2_Terraform_01July2026"
  }
}

###############################################################################
# Create Security Group
# Security Groups act as Virtual Firewalls.
###############################################################################
resource "aws_security_group" "allow_ssh" {

  # Security Group Name.
  name = "allow_ssh"

  # Description shown in AWS Console.
  description = "Allow ssh inbound traffic"

  # Attach Security Group to the VPC.
  vpc_id = aws_vpc.VPCTerraform01July2026.id

  ###########################################################################
  # Inbound Rule - SSH
  ###########################################################################
  ingress {

    # Starting Port.
    from_port = 22

    # Ending Port.
    to_port = 22

    # TCP Protocol.
    protocol = "tcp"

    # Allow SSH from anywhere.
    # In production, replace with your public IP.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################################
  # Inbound Rule - HTTP
  ###########################################################################
  ingress {

    # HTTP Port.
    from_port = 80

    # HTTP Port.
    to_port = 80

    # TCP Protocol.
    protocol = "tcp"

    # Allow web traffic from anywhere.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################################
  # Outbound Rule
  # Allow all outbound traffic.
  ###########################################################################
  egress {

    # Start Port.
    from_port = 0

    # End Port.
    to_port = 0

    # -1 means all protocols.
    protocol = "-1"

    # Allow outbound traffic to anywhere.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {

    # Name displayed in AWS Console.
    Name = "AllowSSH_HTTP"
  }
}