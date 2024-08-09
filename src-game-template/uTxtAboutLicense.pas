unit uTxtAboutLicense;

interface

function GetTxtAboutLicense(const Language: string;
  const Recursif: boolean = false): string;

implementation

// For the languages codes, please use 2 letters ISO codes
// https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes

uses
  System.SysUtils,
  uConsts;

{$MESSAGE WARN 'Personalize your game EULA for the default CREDIT scene and About box dialog'}
// TODO : Personalize your game EULA for the default CREDIT scene and About box dialog

const
  CTxtEN = 'your EULA (end user license agreement)';
  // CTxtFR = '';
  // CTxtIT = '';
  // CTxtDE = '';
  // CTxtJP = '';
  // CTxtPT = '';
  // CTxtES = '';

function GetTxtAboutLicense(const Language: string;
  const Recursif: boolean): string;
var
  lng: string;
begin
  lng := Language.tolower;
  if (lng = 'en') then // Not everywhere in the world but should be present
    result := CTxtEN
    // else if (lng = 'fr') then // France
    // result := CTxtFR
    // else if (lng = 'it') then // Italy
    // result := CTxtIT
    // else if (lng = 'de') then // Germany
    // result := CTxtDE
    // else if (lng = 'jp') then // Japan
    // result := CTxtJP
    // else if (lng = 'pt') then // Portugal
    // result := CTxtPT
    // else if (lng = 'es') then // Spain
    // result := CTxtES
  else if not Recursif then
    result := GetTxtAboutLicense(CDefaultLanguage, true)
  else
    raise Exception.Create('Unknow license for language "' + Language + '".');
end;

end.
