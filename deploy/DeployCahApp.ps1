function Get-RandomCharacters($length, $characters) {
	$random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
	$private:ofs = ""
	return [String]$characters[$random]
}

function Get-CharsInRange([char] $start, [char] $end) {
	$alphabet = @()
	if ([byte][char]$start -GT [byte][char]$end) {
		throw "Start character '$start' greater than end character '$end'"
	}
	
	for ([byte]$c = [char]$start; $c -LE [char]$end; $c++) {
		$alphabet += [char]$c
	}
	
	return $alphabet
}

function Get-EscapedXMLString([string] $str) {
	$updatedStr = $str -replace '&', '&amb;'
	$updatedStr = $str -replace '<', '&lt;'

	return $updatedStr
}

$resourceGroupName = "cah-personal-rg"
Get-AzResourceGroup -Name $resourceGroupName -ErrorAction "SilentlyContinue" -ErrorVariable rgDne
if ($rgDne) {
	Write-Verbose "Creating new resource group $resourceGroupName"
	New-AzResourceGroup -Name $resourceGroupName
}

$length = Get-Random -Minimum 15 -Maximum 20
$passwordChars = $()
$passwordChars += (Get-CharsInRange 'A' 'Z')
$passwordChars += (Get-CharsInRange 'a' 'z')
$passwordChars += (Get-CharsInRange '0' '9')
$specialChars = $('!', '#', '$', '%', '(', ')', '*', '+', ',', '-', '.', ':', ';', '=', '?', '@', '[', '\', ']', '^', '_', '`', '{', '|', '}', '~', '<', '>', '"', "'")
$passwordChars += $specialChars
$passwordRaw = Get-RandomCharacters $length $passwordChars
$passwordEscaped = Get-EscapedXMLString $passwordRaw

$parameters = @{
	subscriptionId          = "36ad6836-8752-4b78-9116-ba40367fe9bf"
	name                    = "pretendyourexyzzy-ck"
	location                = "East US"
	hostingPlanName         = "ASP-cahpersonalrg-830b"
	serverFarmResourceGroup = "cah-personal-rg"
	sku                     = "PremiumV2"
	skuCode                 = "P1v2"
	appPasswordRaw          = $passwordRaw
	appPasswordEscaped      = $passwordEscaped
	dbUrl                   = "sqlite:/pyx.sqlite"
	dbUsername              = "cah"
	dbPassword              = "doesntmatter"
	linuxFxVersion          = "DOCKER|jnfoote76/pretendyourexyzzy:sqlite"
}

Write-Verbose "Starting deployment..."

$templateFilePath = Join-Path $PSScriptRoot "template.json"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -TemplateParameterObject $parameters