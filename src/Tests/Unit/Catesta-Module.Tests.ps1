#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'Catesta'
$PathToManifest = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psd1")
$PathToModule = [System.IO.Path]::Combine('..', '..', $ModuleName, "$ModuleName.psm1")
#-------------------------------------------------------------------------
Describe 'Module Tests' -Tag Unit {
    Context "Module Tests" {
        $script:manifestEval = $null
        It 'Passes Test-ModuleManifest' {
            { $script:manifestEval = Test-ModuleManifest -Path $PathToManifest } | Should Not throw
            $? | Should Be $true
        }#manifestTest
        It 'root module Catesta.psm1 should exist' {
            $PathToModule | Should Exist
            $? | Should Be $true
        }#psm1Exists
        It 'manifest should contain Catesta.psm1' {
            $PathToManifest | Should -FileContentMatchExactly "Catesta.psm1"
        }#validPSM1
        It 'should have a matching module name in the manifest' {
            $script:manifestEval.Name | Should Be $ModuleName
        }#name
        It 'should have a valid description in the manifest' {
            $script:manifestEval.Description | Should Not BeNullOrEmpty
        }#description
        It 'should have a valid author in the manifest' {
            $script:manifestEval.Author | Should Not BeNullOrEmpty
        }#author
        It 'should have a valid version in the manifest' {
            $script:manifestEval.Version -as [Version] | Should Not BeNullOrEmpty
        }#version
        It 'should have a valid guid in the manifest' {
            { [guid]::Parse($script:manifestEval.Guid) } | Should Not throw
        }#guid
    }#context_ModuleTests
}#describe_ModuleTests
