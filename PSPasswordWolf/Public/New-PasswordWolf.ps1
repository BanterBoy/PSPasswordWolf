function New-PasswordWolf {

    <#
        .SYNOPSIS
        Password Function created using the https://passwordwolf.com API to generate passwords.
        All options and defaults on the site have been replicated within this function.

        .DESCRIPTION
        The New-PasswordWolf Password Function was created using Invoke-RestMethod to access the https://passwordwolf.com API and parse the JSON to harvest the generated passwords.

        I have included all of the options and pre-configured the parameter defaults, replicating the website settings.

        "https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"

        Variable	Values      Default             Description
        upper	off/on                          Turns the upper case characters on or off.
        lower	off/on                          Turns the lower case characters on or off.
        numbers	off/on                          Turns numbers on or off.
        special	off/on                          Turns special characters on or off.
        length	1-128       15  	        Set the password length.
        exclude	[string]    ?!<>li1I08OB	Indicates which characters to exclude.
        repeat	1-128       9                   Indicates how many passwords to generate.

        More information can be found by visiting the PasswordWolf website - https://passwordwolf.com
        
        .EXAMPLE
        PS C:\> New-PasswordWolf -upper off -lower on -numbers on -special on -length 15 -repeat 5

        This Example generates 5 passwords with numbers, lowercase and special characters at a length of 15 characters.

        password        phonetic
        --------        --------
        01@6f43nqn%!<25 zero one at six foxtrot four three november quebec november percent exclamation less-than two five   
        o0q-mj254e,*r^- oscar zero quebec dash mike juliet two five four echo comma star romeo caret dash
        ^s)79sz4!(*-o0. caret sierra right-paren seven nine sierra zulu four exclamation left-paren star dash oscar zero dot 
        gw,hj)pi7w,xk7j golf whiskey comma hotel juliet right-paren pappa india seven whiskey comma xray kilo seven juliet   
        `$%lfn<w39lt.1h back-tick dollar percent lima foxtrot november less-than whiskey three nine lima tango dot one hotel

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper on -lower off -numbers off -special off -length 15 -repeat 1

        This Example generates 1 password with uppercasecharacters at a length of 15 characters.

        password        phonetic
        --------        --------
        QFJZKCVADEDQEPH QUEBEC FOXTROT JULIET ZULU KILO CHARLIE VICTOR ALPHA DELTA ECHO DELTA QUEBEC ECHO PAPPA HOTEL

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper off -lower on -numbers off -special off -length 15 -repeat 1

        This Example generates 1 password with lowercase characters at a length of 15 characters.

        password        phonetic
        --------        --------
        iredgqzsjjfliir india romeo echo delta golf quebec zulu sierra juliet juliet foxtrot lima india india romeo

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper on -lower off -numbers on -special on -length 10 -repeat 2 -WhatIf

        This Example uses WhatIf to show the outcome of the command to generates 2 passwords with numbers, uppercase and special characters at a length of 10 characters.

        What if: Performing the operation "Invoke-RestMethod" on target "https://passwordwolf.com/api/?length=10&upper=on&lower=off&numbers=on&special=on&repeat=2".

        .INPUTS
        [switch]    upper       - Default = on
        [switch]    lower       - Default = off
        [switch]    numbers     - Default = on
        [switch]    special     - Default = on
        [int]       length      - Default = 10
        [int]       repeat      - Default = 2

        .OUTPUTS
        [String] password
        [String] phonetic

        .NOTES
        Function to generate secure passwords by accessing an API and parsing the JSON.
        Website: https://passwordwolf.com
        Information regarding the API and access to the Web Interface can be found at the PasswordWolf website.

        .FUNCTIONALITY
        A function providing granular control over generating passwords, utilising an API to create secure passwords in a variety of configurations.
    #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias('ngp')]
    [OutputType([String])]
    Param (
        # Turns the upper case characters on or off. Value can be On or Off. On will enable uppercase characters. Default value is off.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $upper = 'off',
    
        # Turns the lower case characters on or off. Value can be On or Off. On will enable lowercase characters. Default value is on.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $lower = 'on',
    
        # Turns numbers on or off. Value can be On or Off. On will enable numbers. Default value is on.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $numbers = 'on',
    
        # Turns special characters on or off. Value can be On or Off. On will enable special characters. Default value is off.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $special = 'off',
    
        # Set the password length. Value can be between 1 - 128. Specifies the length of the password generated. Length defaults to 10 characters.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateRange (1 , 128)]
        [int]
        $length = 10,
    
        # Indicates which characters to exclude. String Value, enter special characters that you want to exclude. Default exclusion values '?!<>li1I08OB'
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [string]
        $exclude = "?!<>li1I08OB",
    
        # Indicates how many passwords to generate. Enter the number of passwords that you want to generate. Default value is 5 and will generate 5 passwords if a value is not specified.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateRange (1 , 128)]
        [int]
        $repeat = 5
    
    )
        
    begin {
    
    }
        
    process {
    
        $endpoint = "https://passwordwolf.com/api/?"
        $long = "length=$($length)"
        $up = "&upper=$($upper)"
        $low = "&lower=$($lower)"
        $num = "&numbers=$($numbers)"
        $spec = "&special=$($special)"
        $rep = "&repeat=$($repeat)"
        $uri = $endpoint + $long + $up + $low + $num + $spec + $rep
    
        if ($pscmdlet.ShouldProcess("$uri", "Invoke-RestMethod")) {
            Invoke-RestMethod -Method Get -Uri $uri
        }
    
    }
        
    end {
    
    }
}
