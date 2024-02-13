$Server = "localhost" 
$userId = "sa" 
$passwd = "sunset@919325"
$dbName = "master"

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
    'adx_supply'
    )
$folder = "/Users/yannonghuang/Documents/personal/projects/SRI/Import prospects/Adexa/Innolight/PoC 2023/Adexa Feeds/csv_deduped/"

$ConnectionString = "Server=$serverDN;Database=$dbName;User Id=$userId;Password=$passwd;TrustServerCertificate=True"



for ($i = 0; $i -lt $tables.Length; $i++) {
    $query = "SELECT * FROM " + $tables[$i]
    $file = $folder + $tables[$i] + "_inno.csv"

    Invoke-Sqlcmd  -ConnectionString $ConnectionString -Query $query  | 
    Export-Csv -UseQuotes Never -NoTypeInformation -Encoding UTF8 -Path $file ","

}

