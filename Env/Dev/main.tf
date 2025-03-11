module "TRG" {
  source = "../../Modules/1.RG"
  RG     = var.MRG
}
module "Tvnet" {
  source     = "../../Modules/2.Vnet"
  RG         = var.MRG
  depends_on = [module.TRG]
}
module "Tsnet" {
  source     = "../../Modules/3.Subnet"
  RG         = var.MRG
  depends_on = [module.Tvnet]
}
module "Tnsg" {
  source     = "../../Modules/4.NSG"
  RG         = var.MRG
  depends_on = [module.Tvnet]
}
module "Tpip" {
  source = "../../Modules/5.PIP"
  RG = var.MRG
  depends_on = [ module.Tvnet ]
}
module "Tnic" {
  source = "../../Modules/7.NIC"
  RG = var.MRG
  depends_on = [ module.Tvnet ]
}
module "Tvm" {
  source = "../../Modules/6.VM"
  RG = var.MRG
  depends_on = [ module.Tnic ]
}
