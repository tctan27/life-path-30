# Rebuilds index.html from the game file Claude edits (an artifact page with no <head> of its own),
# adding the page head, the phone-app (PWA) tags and the offline service worker.
$src = Join-Path $PSScriptRoot "..\app for customer\life-path-3d.html"
$t = [IO.File]::ReadAllText($src, [Text.Encoding]::UTF8)
$i = $t.IndexOf("</style>") + "</style>".Length
$head = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="A 3D 30-year life simulator: pick a life card each year, decide on income protection, and see your net worth and happiness at the end.">
<meta name="theme-color" content="#0E6B5C">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="Life Path 30">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" type="image/png" href="icons/favicon-64.png">
<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">
"@
$tail = @"

<script>
if ("serviceWorker" in navigator) window.addEventListener("load", () => navigator.serviceWorker.register("sw.js").catch(() => {}));
</script>
</body>
</html>
"@
$html = $head + $t.Substring(0, $i) + "`n</head>`n<body>" + $t.Substring($i) + $tail
[IO.File]::WriteAllText((Join-Path $PSScriptRoot "index.html"), $html, (New-Object Text.UTF8Encoding $false))
"index.html rebuilt"
