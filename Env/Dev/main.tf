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
  source     = "../../Modules/5.PIP"
  RG         = var.MRG
  depends_on = [module.Tvnet]
}
module "Tnic" {
  source     = "../../Modules/7.NIC"
  RG         = var.MRG
  depends_on = [module.Tvnet]
}
module "Tvm" {
  source     = "../../Modules/6.VM"
  RG         = var.MRG
  depends_on = [module.Tnic]
}
module "Tkv" {
  source     = "../../Modules/8.keyvault"
  RG         = var.MRG
  depends_on = [module.TRG]
}
module "Tstg" {
  source     = "../../Modules/9.stg"
  RG         = var.MRG
  depends_on = [module.TRG]
}
module "Tsql" {
  source     = "../../Modules/10.sqlserver"
  RG         = var.MRG
  depends_on = [module.TRG]
}
module "Tlb" {
  source     = "../../Modules/11.lb"
  RG         = var.MRG
  depends_on = [module.TRG]
}