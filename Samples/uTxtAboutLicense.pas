/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// The "Gamolf FMX Game Template" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside, and a reusable
/// project template you can customize for your own games.
///
/// The files provided are fully functional. Numerous comments are included in
/// the sources to explain how they work and what you need to copy, override
/// or customize to make video games without starting from scratch.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://gametemplate.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Template
///
/// ***************************************************************************
/// File last update : 2024-08-09T20:35:48.000+02:00
/// Signature : 4aa97c14420520c49ba16f5fc0e22f7d0d0f6e7a
/// ***************************************************************************
/// </summary>

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

const
  // TODO : translate the text if you want or need it (you MUST have your "CDefaultLanguage" in the list)
  CTxtEN = '''
This program is distributed as shareware. If you use it (especially for commercial or income-generating purposes), please remember the author and contribute to its development by purchasing a license.

This software is supplied as is, with or without bugs. No warranty is offered as to its operation or the data processed. Make backups!
''';
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
  if (lng = 'en') then
    result := CTxtEN
    // TODO : add your translations here
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
    // etc...
  else if not Recursif then
    result := GetTxtAboutLicense(CDefaultLanguage, true)
  else
    raise Exception.Create('Unknow license for language "' + Language + '".');
end;

end.
