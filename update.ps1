import-module au

$releases = 'https://github.com/jhipster/generator-jhipster/releases'

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
    "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  #https://github.com/jhipster/generator-jhipster/archive/v4.13.0.zip
  $re  = "(.*).zip"
  $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href
  $file = $url -split 'v' | Select-Object -last 1

  $version = [IO.Path]::GetFileNameWithoutExtension($file)

  @{
    Version = $version
  }
}

update -ChecksumFor none
