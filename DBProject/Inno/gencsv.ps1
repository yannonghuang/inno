$serverDN = "localhost" 
$userId = "sa" 
$passwd = "sunset@919325"
$dbName = "Inno"

$tables = @(
    'adx_bom',
    'adx_productlocation',
    'adx_method_buy',
    'adx_method_make',
    'adx_transportation',
    'adx_vendor',
    'adx_product',
    'adx_demand',
    'adx_customer',
    'adx_supply',
    'adx_route',
    'adx_operation',	
    'adx_bor',
    'adx_bora',		
    'adx_resalt',		
    'adx_resource',
    'adx_rescapinter',
    'adx_op_override',
    'adx_graybox',
    'adx_cfi_family'    
    )
#$folder = "/Users/yannonghuang/Documents/personal/projects/SRI/Import prospects/Adexa/Innolight/PoC 2023/Adexa Feeds/csv_deduped/"
$folder = "/Users/yannonghuang/Documents/personal/projects/SRI/Import prospects/Adexa/Innolight/PoC 2023/Adexa Feeds/DBProject/Inno/build/DATA/"

$ConnectionString = "Server=$serverDN;Database=$dbName;User Id=$userId;Password=$passwd;TrustServerCertificate=True"

for ($i = 0; $i -lt $tables.Length; $i++) {
    $query = "SELECT * FROM " + $tables[$i]
    if ($tables[$i] -eq "adx_graybox") {
        $query += ' order by [LOCATION], COMLOCATION_UDA_PROD_AREA
        ,[COMLOCATION_UDA_PACKAGE]
        ,[COMLOCATION_UDA_TECHNOLOGY]      
        ,CAST(START as date)'
    }

    if ($tables[$i] -eq "adx_bom") {
        $query += ' order by PARENT_ID, CHILD_ID '
    }

    $file = $folder + $tables[$i] + "_inno.csv"

    Invoke-Sqlcmd  -ConnectionString $ConnectionString -Query $query  | 
    Export-Csv -UseQuotes Never -NoTypeInformation -Encoding UTF8 -Path $file ","

}


#adx_cappattern	

