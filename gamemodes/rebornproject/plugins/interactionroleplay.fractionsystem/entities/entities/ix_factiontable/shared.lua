AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Faction Table"
ENT.Category = "[cmbmtk]"
ENT.Spawnable = true

ENT.AdminSpawnable = true


function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Fraction")
    self:NetworkVar("Int", 1, "CurrStorage")
    self:NetworkVar("Int", 2, "MaxStorage")
    self:NetworkVar("Int", 3, "PassiveIncome" )
    self:NetworkVar("Int", 4, "UpgradeCostStorage")
    self:NetworkVar("Int", 5, "UpgradeCostPassive")
    self:NetworkVar("Int", 6, "BankID")
    self:NetworkVar("Int", 7, "BankWH")
    self:NetworkVar("Int", 8, "UpgradeCostBank")

    local UpgradeCostStorage = self:GetUpgradeCostStorage() ~= 0 and self:GetUpgradeCostStorage() or 100

    local UpgradeCostPassive = self:GetUpgradeCostPassive() ~= 0 and self:GetUpgradeCostPassive() or 250

    local CurrStorage = self:GetCurrStorage() ~= 0 and self:GetCurrStorage() or 0
    local MaxStorage = self:GetMaxStorage() ~= 0 and self:GetMaxStorage() or 750
    local Fraction = self:GetFraction() ~= 0 and self:GetFraction() or 1
    local PassiveIncome = self:GetPassiveIncome()


    self:SetUpgradeCostStorage(UpgradeCostStorage)
    self:SetUpgradeCostPassive(UpgradeCostPassive)

    self:SetPassiveIncome(PassiveIncome)
    self:SetCurrStorage(CurrStorage)
    self:SetMaxStorage(MaxStorage)
    self:SetFraction(Fraction)

    local UpgradeCostBank = self:GetUpgradeCostBank() ~= 0 and self:GetUpgradeCostBank() or 100
    local CurrBank = self:GetBankWH() ~= 0 and self:GetBankWH() or 4

    self:SetBankID(0)
    self:SetBankWH(CurrBank)
    self:SetUpgradeCostBank(UpgradeCostBank)
end
