module "TRG" {
  source = "../../Modules/1.RG"
  RG = var.MRG
}
module "Tvnet" {
    source = "../../Modules/2.Vnet"
    RG = Var.MRG
}
module "Tsnet" {
  source = "../../Modules/3.Subnet"
  RG = var.MRG
}