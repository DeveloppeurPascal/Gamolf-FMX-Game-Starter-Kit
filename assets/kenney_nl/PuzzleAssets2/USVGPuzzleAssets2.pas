(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
  game developed in Delphi with everything you need inside and a reusable
  project template you can customize for your own games.

  The files provided are fully functional. Numerous comments are included in
  the sources to explain how they work and what you need to copy, override
  or customize to make video games without starting from scratch.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxgamestarterkit.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2025-07-13T16:04:27.494+02:00
  Signature : 1569c76ce5087040c81d5e424914a962c94b390c
  ***************************************************************************
*)

unit USVGPuzzleAssets2;

// ****************************************
// * SVG from folder :
// * .\
// ****************************************
//
// This file contains a list of constants and
// an enumeration to access to SVG source codes
// from the generated array of strings.
//
// ****************************************
// File generator : SVG Folder To Delphi Unit v2.0
// Website : https://svgfolder2delphiunit.olfsoftware.fr
// Generation date : 2025-07-13T16:04:27.481Z
//
// Don't do any change on this file.
// They will be erased by next generation !
// ****************************************

interface

{$IF Defined(FRAMEWORK_VCL)}

uses
  VCL.Graphics;
{$ELSE IF Defined(FRAMEWORK_FMX)}

uses
  FMX.Graphics;
{$ELSE}
{$MESSAGE FATAL 'Is it a VCL or FMX program ?'}
{$ENDIF}

const
  CSVGBtnFocus = 0;
  CSVGBtnOff = 1;
  CSVGBtnOn = 2;

type
{$SCOPEDENUMS ON}
  TSVGPuzzleAssets2Index = (
    BtnFocus = CSVGBtnFocus,
    BtnOff = CSVGBtnOff,
    BtnOn = CSVGBtnOn);

  TSVGPuzzleAssets2 = class
  private
  class var
    FTag: integer;
    FTagBool: Boolean;
    FTagFloat: Single;
    FTagObject: TObject;
    FTagString: string;
    FBitmapListIndex: integer;
    class procedure SetTag(const Value: integer); static;
    class procedure SetTagBool(const Value: Boolean); static;
    class procedure SetTagFloat(const Value: Single); static;
    class procedure SetTagObject(const Value: TObject); static;
    class procedure SetTagString(const Value: string); static;
  public const
    BtnFocus = CSVGBtnFocus;
    BtnOff = CSVGBtnOff;
    BtnOn = CSVGBtnOn;
    class property Tag: integer read FTag write SetTag;
    class property TagBool: Boolean read FTagBool write SetTagBool;
    class property TagFloat: Single read FTagFloat write SetTagFloat;
    class property TagObject: TObject read FTagObject write SetTagObject;
    class property TagString: string read FTagString write SetTagString;
    class function SVG(const Index: Integer): string; overload;
    class function SVG(const Index: TSVGPuzzleAssets2Index) : string; overload;
    class function Count : Integer;
    class constructor Create;
    class function Bitmap(const Index: TSVGPuzzleAssets2Index;
      const width, height: single; const BitmapScale: single): TBitmap;
  end;

var
  SVGPuzzleAssets2 : array of String;

/// <summary>
/// Returns a bitmap from a TSVGPuzzleAssets2 SVG file
/// </summary>
function getBitmapFromSVG(const Index: TSVGPuzzleAssets2Index;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

implementation

uses
  Olf.Skia.SVGToBitmap,
  System.SysUtils;

{ TSVGPuzzleAssets2 }

class constructor TSVGPuzzleAssets2.Create;
begin
  inherited;
  FBitmapListIndex := 0;
  FTag := 0;
  FTagBool := false;
  FTagFloat := 0;
  FTagObject := nil;
  FTagString := '';
end;

class procedure TSVGPuzzleAssets2.SetTag(const Value: integer);
begin
  FTag := Value;
end;

class procedure TSVGPuzzleAssets2.SetTagBool(const Value: Boolean);
begin
  FTagBool := Value;
end;

class procedure TSVGPuzzleAssets2.SetTagFloat(const Value: Single);
begin
  FTagFloat := Value;
end;

class procedure TSVGPuzzleAssets2.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

class procedure TSVGPuzzleAssets2.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

class function TSVGPuzzleAssets2.SVG(const Index: Integer): string;
begin
  if (index < Count) then
    result := SVGPuzzleAssets2[index]
  else
    raise Exception.Create('SVG not found. Index out of range.');
end;

class function TSVGPuzzleAssets2.SVG(const Index : TSVGPuzzleAssets2Index): string;
begin
  result := SVG(ord(index));
end;

class function TSVGPuzzleAssets2.Count: Integer;
begin
  result := length(SVGPuzzleAssets2);
end;

class function TSVGPuzzleAssets2.Bitmap(const Index: TSVGPuzzleAssets2Index;
  const width, height: single; const BitmapScale: single): TBitmap;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGPuzzleAssets2.FBitmapListIndex,
    round(width), round(height), BitmapScale);
end;

procedure RegisterSVGBitmap;
begin
  TSVGPuzzleAssets2.FBitmapListIndex := TOlfSVGBitmapList.AddItem(SVGPuzzleAssets2);
end;

function getBitmapFromSVG(const Index: TSVGPuzzleAssets2Index;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  Result := TSVGPuzzleAssets2.Bitmap(Index, width, height, BitmapScale);
end;

initialization

SetLength(SVGPuzzleAssets2, 3);

SVGPuzzleAssets2[CSVGBtnFocus] := 
  '<?xml version="1.0" encoding="UTF-8"?><svg id="Calque_2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 104 54"><g id="Calque_1'
  + '-2"><path d="M104,5v44c0,1.37-.48,2.55-1.45,3.55-1,.97-2.18,1.45-3.55,1.45H5c-1.37,0-2.53-.48-3.5-1.45s-1.5-2.18-1.5-3.55V5c0-1.'
  + '37.5-2.53,1.5-3.5C2.47.5,3.63,0,5,0h94c1.37,0,2.55.5,3.55,1.5.97.97,1.45,2.13,1.45,3.5M99,5H5v44h94V5" fill="#fff" stroke-width='
  + '"0"/><path d="M13,13h78v28H13V13" fill="#f9c" stroke-width="0"/><path d="M99,5l-8,8H13L5,5h94" fill="#ffd2e8" stroke-width="0"/>'
  + '<path d="M91,13l8-8v44l-8-8V13M5,5l8,8v28l-8,8V5" fill="#ffaad4" stroke-width="0"/><path d="M91,41l8,8H5l8-8h78" fill="#f080b8" '
  + 'stroke-width="0"/></g></svg>'
;
SVGPuzzleAssets2[CSVGBtnOff] := 
  '<?xml version="1.0" encoding="UTF-8"?><svg id="Calque_2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 104 54"><g id="Calque_1'
  + '-2"><path d="M13,41V13h78v28H13" fill="#f9c" stroke-width="0"/><path d="M13,13L5,5h94l-8,8H13" fill="#ffd2e8" stroke-width="0"/>'
  + '<path d="M13,13v28l-8,8V5l8,8M99,5v44l-8-8V13l8-8" fill="#ffaad4" stroke-width="0"/><path d="M5,49l8-8h78l8,8H5" fill="#f080b8" '
  + 'stroke-width="0"/><path d="M5,49h94V5H5v44M5,0h94c1.37,0,2.55.5,3.55,1.5s1.45,2.13,1.45,3.5v44c0,1.37-.48,2.55-1.45,3.55-1,.97-2'
  + '.18,1.45-3.55,1.45H5c-1.37,0-2.53-.48-3.5-1.45s-1.5-2.18-1.5-3.55V5c0-1.37.5-2.53,1.5-3.5.97-1,2.13-1.5,3.5-1.5" fill="#c45a8f" '
  + 'stroke-width="0"/></g></svg>'
;
SVGPuzzleAssets2[CSVGBtnOn] := 
  '<?xml version="1.0" encoding="UTF-8"?><svg id="Calque_2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 94 44"><g id="Calque_1-'
  + '2"><path d="M8,8h78v28H8V8" fill="#f9c" stroke-width="0"/><path d="M94,0l-8,8H8L0,0h94" fill="#ffd2e8" stroke-width="0"/><path d'
  + '="M86,8L94,0v44l-8-8V8M0,0l8,8v28L0,44V0" fill="#ffaad4" stroke-width="0"/><path d="M86,36l8,8H0l8-8h78" fill="#f080b8" stroke-w'
  + 'idth="0"/></g></svg>'
;

RegisterSVGBitmap;

end.
