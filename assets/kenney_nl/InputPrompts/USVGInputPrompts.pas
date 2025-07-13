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
  File last update : 2025-07-13T16:04:02.705+02:00
  Signature : ffec51caec299dd1d198098aed58a609bf66deca
  ***************************************************************************
*)

unit USVGInputPrompts;

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
// Generation date : 2025-07-13T16:04:02.687Z
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
  CSVGKeyboardArrowDown = 0;
  CSVGKeyboardArrowLeft = 1;
  CSVGKeyboardArrowRight = 2;
  CSVGKeyboardArrowUp = 3;
  CSVGKeyboardEscape = 4;
  CSVGKeyboardReturn = 5;
  CSVGKeyboardSpace = 6;
  CSVGSteamButtonColorAOutline = 7;
  CSVGSteamButtonColorBOutline = 8;
  CSVGSteamButtonColorXOutline = 9;
  CSVGSteamDpadDownOutline = 10;
  CSVGSteamDpadLeftOutline = 11;
  CSVGSteamDpadNone = 12;
  CSVGSteamDpadRightOutline = 13;
  CSVGSteamDpadUpOutline = 14;

type
{$SCOPEDENUMS ON}
  TSVGInputPromptsIndex = (
    KeyboardArrowDown = CSVGKeyboardArrowDown,
    KeyboardArrowLeft = CSVGKeyboardArrowLeft,
    KeyboardArrowRight = CSVGKeyboardArrowRight,
    KeyboardArrowUp = CSVGKeyboardArrowUp,
    KeyboardEscape = CSVGKeyboardEscape,
    KeyboardReturn = CSVGKeyboardReturn,
    KeyboardSpace = CSVGKeyboardSpace,
    SteamButtonColorAOutline = CSVGSteamButtonColorAOutline,
    SteamButtonColorBOutline = CSVGSteamButtonColorBOutline,
    SteamButtonColorXOutline = CSVGSteamButtonColorXOutline,
    SteamDpadDownOutline = CSVGSteamDpadDownOutline,
    SteamDpadLeftOutline = CSVGSteamDpadLeftOutline,
    SteamDpadNone = CSVGSteamDpadNone,
    SteamDpadRightOutline = CSVGSteamDpadRightOutline,
    SteamDpadUpOutline = CSVGSteamDpadUpOutline);

  TSVGInputPrompts = class
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
    KeyboardArrowDown = CSVGKeyboardArrowDown;
    KeyboardArrowLeft = CSVGKeyboardArrowLeft;
    KeyboardArrowRight = CSVGKeyboardArrowRight;
    KeyboardArrowUp = CSVGKeyboardArrowUp;
    KeyboardEscape = CSVGKeyboardEscape;
    KeyboardReturn = CSVGKeyboardReturn;
    KeyboardSpace = CSVGKeyboardSpace;
    SteamButtonColorAOutline = CSVGSteamButtonColorAOutline;
    SteamButtonColorBOutline = CSVGSteamButtonColorBOutline;
    SteamButtonColorXOutline = CSVGSteamButtonColorXOutline;
    SteamDpadDownOutline = CSVGSteamDpadDownOutline;
    SteamDpadLeftOutline = CSVGSteamDpadLeftOutline;
    SteamDpadNone = CSVGSteamDpadNone;
    SteamDpadRightOutline = CSVGSteamDpadRightOutline;
    SteamDpadUpOutline = CSVGSteamDpadUpOutline;
    class property Tag: integer read FTag write SetTag;
    class property TagBool: Boolean read FTagBool write SetTagBool;
    class property TagFloat: Single read FTagFloat write SetTagFloat;
    class property TagObject: TObject read FTagObject write SetTagObject;
    class property TagString: string read FTagString write SetTagString;
    class function SVG(const Index: Integer): string; overload;
    class function SVG(const Index: TSVGInputPromptsIndex) : string; overload;
    class function Count : Integer;
    class constructor Create;
    class function Bitmap(const Index: TSVGInputPromptsIndex;
      const width, height: single; const BitmapScale: single): TBitmap;
  end;

var
  SVGInputPrompts : array of String;

/// <summary>
/// Returns a bitmap from a TSVGInputPrompts SVG file
/// </summary>
function getBitmapFromSVG(const Index: TSVGInputPromptsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

implementation

uses
  Olf.Skia.SVGToBitmap,
  System.SysUtils;

{ TSVGInputPrompts }

class constructor TSVGInputPrompts.Create;
begin
  inherited;
  FBitmapListIndex := 0;
  FTag := 0;
  FTagBool := false;
  FTagFloat := 0;
  FTagObject := nil;
  FTagString := '';
end;

class procedure TSVGInputPrompts.SetTag(const Value: integer);
begin
  FTag := Value;
end;

class procedure TSVGInputPrompts.SetTagBool(const Value: Boolean);
begin
  FTagBool := Value;
end;

class procedure TSVGInputPrompts.SetTagFloat(const Value: Single);
begin
  FTagFloat := Value;
end;

class procedure TSVGInputPrompts.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

class procedure TSVGInputPrompts.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

class function TSVGInputPrompts.SVG(const Index: Integer): string;
begin
  if (index < Count) then
    result := SVGInputPrompts[index]
  else
    raise Exception.Create('SVG not found. Index out of range.');
end;

class function TSVGInputPrompts.SVG(const Index : TSVGInputPromptsIndex): string;
begin
  result := SVG(ord(index));
end;

class function TSVGInputPrompts.Count: Integer;
begin
  result := length(SVGInputPrompts);
end;

class function TSVGInputPrompts.Bitmap(const Index: TSVGInputPromptsIndex;
  const width, height: single; const BitmapScale: single): TBitmap;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGInputPrompts.FBitmapListIndex,
    round(width), round(height), BitmapScale);
end;

procedure RegisterSVGBitmap;
begin
  TSVGInputPrompts.FBitmapListIndex := TOlfSVGBitmapList.AddItem(SVGInputPrompts);
end;

function getBitmapFromSVG(const Index: TSVGInputPromptsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  Result := TSVGInputPrompts.Bitmap(Index, width, height, BitmapScale);
end;

initialization

SetLength(SVGInputPrompts, 15);

SVGInputPrompts[CSVGKeyboardArrowDown] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M8 48 L8 16 Q8 8 16 8 L48 8 Q56 8 56 16 L56 48 Q56 56 48 56 L16 56 Q8 56 8 48 M32 42 L'
  + '40 34 40 32 36 32 36 22 28 22 28 32 24 32 24 34 32 42"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardArrowLeft] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M16 8 L48 8 Q56 8 56 16 L56 48 Q56 56 48 56 L16 56 Q8 56 8 48 L8 16 Q8 8 16 8 M22 32 L'
  + '30 40 32 40 32 36 42 36 42 28 32 28 32 24 30 24 22 32"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardArrowRight] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M42 32 L34 24 32 24 32 28 22 28 22 36 32 36 32 40 34 40 42 32 M48 56 L16 56 Q8 56 8 48'
  + ' L8 16 Q8 8 16 8 L48 8 Q56 8 56 16 L56 48 Q56 56 48 56"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardArrowUp] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M56 16 L56 48 Q56 56 48 56 L16 56 Q8 56 8 48 L8 16 Q8 8 16 8 L48 8 Q56 8 56 16 M32 22 '
  + 'L24 30 24 32 28 32 28 42 36 42 36 32 40 32 40 30 32 22"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardEscape] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M16 8 L48 8 Q56 8 56 16 L56 48 Q56 56 48 56 L16 56 Q8 56 8 48 L8 16 Q8 8 16 8 M44.8 37'
  + ' Q46.05 35.8 46 34.3 L46 32.8 43 32.8 43 34.3 42.75 34.8 42 35 41.2 34.8 41 34.3 41 28.75 41.2 28.3 41.25 28.25 Q41.55 28 42 28 '
  + '42.45 28 42.8 28.3 L43 28.75 43 30.25 46 30.25 46 28.75 Q46 27.15 44.75 26.05 43.55 25 42 25 40.4 25 39.25 26.05 L39.2 26.05 Q38'
  + ' 27.15 38 28.75 L38 34.3 Q38 35.8 39.15 36.95 L39.2 37.05 39.3 37.1 Q40.4 38 42 38 43.55 38 44.7 37.1 L44.8 37 M18 25 L18 38 26 '
  + '38 26 35 21 35 21 33 26 33 26 30 21 30 21 28 26 28 26 25 18 25 M32 28 L36 28 36 25 32 25 Q30.4 25 29.2 26.2 28 27.4 28 29 28 30.'
  + '6 29.2 31.8 30.4 33 31.95 33 L32.05 33 Q32.4 33 32.7 33.3 L33 34 32.7 34.7 32 35 28 35 28 38 32 38 Q33.6 38 34.8 36.8 36 35.6 36'
  + ' 34 36 32.4 34.8 31.2 33.6 30 32.05 30 L31.95 30 31.3 29.7 Q31 29.4 31 29 31 28.6 31.3 28.3 31.6 28 32 28"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardReturn] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M48 8 Q56 8 56 16 L56 48 Q56 56 48 56 L16 56 Q8 56 8 48 L8 40 8 38.95 8 36 Q8 28 16 28'
  + ' L28 28 28 16 Q28 8 36 8 L38.95 8 40 8 48 8 M29 41 L35 47 37 47 37 43 44.1 43 Q45.3 42.95 46.1 42.1 46.95 41.3 47 40.1 L47 29 43'
  + ' 29 43 39 37 39 37 35 35 35 29 41"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGKeyboardSpace] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M41.1 36.25 Q42 35.35 42 34.25 L41.7 33.55 Q41.4 33.25 41 33.25 40.6 33.25 40.3 33.55 '
  + '40 33.85 40 34.25 L39.75 34.8 39.75 34.75 39 35 38.2 34.75 38 34.25 38 29.8 Q38 29.45 38.25 29.2 L38.2 29.3 Q38.55 29 39 29 39.4'
  + '5 29 39.75 29.3 L39.75 29.25 40 29.8 Q40 30.2 40.3 30.5 L41 30.8 41.7 30.5 42 29.8 Q42 28.65 41.1 27.8 L41.05 27.75 Q40.15 27 39'
  + ' 27 37.75 27 36.9 27.75 L36.85 27.8 Q36 28.65 36 29.8 L36 34.25 Q36 35.35 36.85 36.2 L36.9 36.3 Q37.75 37 39 37 40.15 37 41.05 3'
  + '6.3 L41.1 36.25 M29 29.8 L29 36 Q29 36.4 29.3 36.7 L30 37 Q30.4 37 30.7 36.7 L31 36 31 34 33 34 33 36 Q33 36.4 33.3 36.7 L34 37 '
  + 'Q34.4 37 34.7 36.7 L35 36 35 29.8 Q35 28.65 34.1 27.8 L34.05 27.75 Q33.15 27 32 27 30.75 27 29.9 27.75 L29.85 27.8 Q29 28.65 29 '
  + '29.8 M31 29.8 Q31 29.45 31.25 29.2 L31.2 29.3 Q31.55 29 32 29 32.45 29 32.75 29.3 L32.75 29.25 33 29.8 33 32 31 32 31 29.8 M48 2'
  + '7 L44 27 Q43.6 27 43.3 27.3 43 27.6 43 28 L43 36 Q43 36.4 43.3 36.7 43.6 37 44 37 L48 37 Q48.4 37 48.7 36.7 L49 36 48.7 35.3 Q48'
  + '.4 35 48 35 L45 35 45 33 48 33 Q48.4 33 48.7 32.7 L49 32 48.7 31.3 Q48.4 31 48 31 L45 31 45 29 48 29 Q48.4 29 48.7 28.7 L49 28 4'
  + '8.7 27.3 Q48.4 27 48 27 M16 18 L48 18 Q56 18 56 26 L56 38 Q56 42.9 53 44.8 51.1 46 48 46 L16 46 Q12.9 46 11 44.8 8 42.9 8 38 L8 '
  + '26 Q8 18 16 18 M18 29 L20 29 20.7 28.7 21 28 20.7 27.3 Q20.4 27 20 27 L18 27 Q16.8 27 15.9 27.9 15 28.8 15 30 15 31.2 15.9 32.1 '
  + '16.8 33 17.95 33 L18.05 33 Q18.4 33 18.7 33.3 L19 34 18.7 34.7 Q18.4 35 18 35 L16 35 Q15.6 35 15.3 35.3 15 35.6 15 36 15 36.4 15'
  + '.3 36.7 L16 37 18 37 Q19.2 37 20.1 36.1 21 35.2 21 34 21 32.8 20.1 31.9 19.2 31 18.05 31 L17.95 31 Q17.6 31 17.3 30.7 17 30.4 17'
  + ' 30 17 29.6 17.3 29.3 17.6 29 18 29 M25.1 33 L26.35 32.7 26.45 32.65 27.1 32.15 27.1 32.1 Q28 31.25 28 30 28 28.75 27.1 27.85 26'
  + '.25 27 25.05 27 L23 27 Q22.6 27 22.3 27.3 22 27.6 22 28 L22 36 Q22 36.4 22.3 36.7 22.6 37 23 37 L23.7 36.7 24 36 24 33 25.1 33 M'
  + '25.1 31 L24 31 24 29 25.05 29 25.7 29.25 26 30 25.75 30.7 25.7 30.7 25.45 30.9 25.1 31"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamButtonColorAOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#7DB700" d="M56 32 Q56 42 48.95 48.95 42 56 32 56 22.05 56 15 48.95 8 42 8 32 8 22.05 15 15 22.05 '
  + '8 32 8 42 8 48.95 15 56 22.05 56 32 M32 27 L29.2 34 34.8 34 32 27 M38 42 L36.4 38 27.6 38 26 42 22 42 30 22 34 22 42 42 38 42 M4'
  + '6.85 17.15 Q40.75 11 32 11 23.3 11 17.15 17.15 11 23.3 11 32 11 40.75 17.15 46.85 23.3 53 32 53 40.75 53 46.85 46.85 53 40.75 53'
  + ' 32 53 23.3 46.85 17.15"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamButtonColorBOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#EF4E29" d="M46.85 17.15 Q40.75 11 32 11 23.3 11 17.15 17.15 11 23.3 11 32 11 40.75 17.15 46.85 23'
  + '.3 53 32 53 40.75 53 46.85 46.85 53 40.75 53 32 53 23.3 46.85 17.15 M56 32 Q56 42 48.95 48.95 42 56 32 56 22.05 56 15 48.95 8 42'
  + ' 8 32 8 22.05 15 15 22.05 8 32 8 42 8 48.95 15 56 22.05 56 32 M40 36 Q40 38.45 38.25 40.2 L38.2 40.25 Q36.45 42 34 42 L24 42 24 '
  + '22 34 22 Q36.45 22 38.2 23.75 L38.25 23.8 Q40 25.55 40 28 40 30.3 38.5 32 40 33.7 40 36 M36 28 Q36 27.2 35.45 26.65 L35.35 26.55'
  + ' Q34.8 26 34 26 L28 26 28 30 34 30 Q34.8 30 35.4 29.4 L35.45 29.4 Q36 28.85 36 28 M36 36 Q36 35.15 35.45 34.6 L35.4 34.6 Q34.8 3'
  + '4 34 34 L28 34 28 38 34 38 Q34.8 38 35.35 37.45 L35.45 37.35 Q36 36.8 36 36"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamButtonColorXOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#009FEB" d="M46.85 17.15 Q40.75 11 32 11 23.3 11 17.15 17.15 11 23.3 11 32 11 40.75 17.15 46.85 23'
  + '.3 53 32 53 40.75 53 46.85 46.85 53 40.75 53 32 53 23.3 46.85 17.15 M56 32 Q56 42 48.95 48.95 42 56 32 56 22.05 56 15 48.95 8 42'
  + ' 8 32 8 22.05 15 15 22.05 8 32 8 42 8 48.95 15 56 22.05 56 32 M23 25 L23 24 25.25 22 26.4 22 32 28.55 37.65 22 38.75 22 41 24 41'
  + ' 25 35 32 41 39 41 40 38.75 42 37.65 42 32 35.5 26.4 42 25.25 42 23 40 23 39 29 32 23 25"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamDpadDownOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M28 36 L20 36 Q18.35 36 17.2 34.85 16 33.65 16 32 16 30.35 17.2 29.2 18.35 28 20 28 L2'
  + '8 28 28 20 Q28 18.35 29.15 17.2 30.35 16 32 16 33.65 16 34.8 17.2 36 18.35 36 20 L36 28 44 28 Q45.65 28 46.85 29.2 48 30.35 48 3'
  + '2 48 33.65 46.85 34.85 45.65 36 44 36 L36 36 28 36 M56 32 Q56 41.95 48.95 49 43.55 54.45 36.35 55.65 L32 56 27.7 55.65 Q20.45 54'
  + '.45 15 49 8 41.95 8 32 8 22 15 15.05 22.05 8 32 8 42 8 48.95 15.05 56 22 56 32 M46.85 46.85 Q53 40.7 53 32 53 23.25 46.85 17.15 '
  + '40.75 11 32 11 23.3 11 17.15 17.15 11 23.25 11 32 11 40.7 17.15 46.85 23.3 53 32 53 40.75 53 46.85 46.85"/>'
  + '    <path stroke="none" fill="#E73246" d="M28 36 L36 36 36 44 Q36 45.65 34.8 46.85 33.65 48 32 48 30.35 48 29.15 46.85 28 45.65 '
  + '28 44 L28 36"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamDpadLeftOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M32 8 Q42 8 48.95 15.05 56 22 56 32 56 41.95 48.95 49 42 56 32 56 22.05 56 15 49 9.55 '
  + '43.55 8.35 36.3 8 34.2 8 32 8 29.75 8.35 27.65 9.55 20.45 15 15.05 22.05 8 32 8 M17.15 17.15 Q11 23.25 11 32 11 40.7 17.15 46.85'
  + ' 23.3 53 32 53 40.75 53 46.85 46.85 53 40.7 53 32 53 23.25 46.85 17.15 40.75 11 32 11 23.3 11 17.15 17.15 M28 28 L28 20 Q28 18.3'
  + '5 29.15 17.15 30.35 16 32 16 33.65 16 34.8 17.15 36 18.35 36 20 L36 28 44 28 Q45.65 28 46.8 29.2 48 30.35 48 32 48 33.65 46.8 34'
  + '.85 45.65 36 44 36 L36 36 36 44 Q36 45.65 34.8 46.8 33.65 48 32 48 30.35 48 29.15 46.8 28 45.65 28 44 L28 36 28 28"/>'
  + '    <path stroke="none" fill="#E73246" d="M28 28 L28 36 20 36 Q18.35 36 17.15 34.85 16 33.65 16 32 16 30.35 17.15 29.2 18.35 28 '
  + '20 28 L28 28"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamDpadNone] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M46.85 17.15 Q40.75 11 32 11 23.3 11 17.15 17.15 11 23.3 11 32 11 40.75 17.15 46.85 23'
  + '.3 53 32 53 40.75 53 46.85 46.85 53 40.75 53 32 53 23.3 46.85 17.15 M56 32 Q56 42 48.95 48.95 42 56 32 56 22.05 56 15 48.95 8 42'
  + ' 8 32 8 22.05 15 15 20.45 9.55 27.7 8.35 L32 8 36.35 8.35 Q43.55 9.55 48.95 15 56 22.05 56 32 M32 16 Q33.65 16 34.8 17.15 36 18.'
  + '35 36 20 L36 28 44 28 Q45.65 28 46.85 29.15 48 30.35 48 32 48 33.65 46.85 34.8 45.65 36 44 36 L36 36 36 44 Q36 45.65 34.8 46.8 3'
  + '3.65 48 32 48 30.35 48 29.15 46.8 28 45.65 28 44 L28 36 20 36 Q18.35 36 17.2 34.8 16 33.65 16 32 16 30.35 17.2 29.15 18.35 28 20'
  + ' 28 L28 28 28 20 Q28 18.35 29.15 17.15 30.35 16 32 16"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamDpadRightOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#E73246" d="M36 28 L44 28 Q45.65 28 46.85 29.2 48 30.35 48 32 48 33.65 46.85 34.85 45.65 36 44 36 '
  + 'L36 36 36 28"/>'
  + '    <path stroke="none" fill="#FFFFFF" d="M36 28 L36 36 36 44 Q36 45.65 34.85 46.8 33.65 48 32 48 30.35 48 29.2 46.8 28 45.65 28'
  + ' 44 L28 36 20 36 Q18.35 36 17.2 34.85 16 33.65 16 32 16 30.35 17.2 29.2 18.35 28 20 28 L28 28 28 20 Q28 18.35 29.2 17.15 30.35 1'
  + '6 32 16 33.65 16 34.85 17.15 36 18.35 36 20 L36 28 M32 8 Q41.95 8 49 15.05 54.45 20.45 55.65 27.65 56 29.75 56 32 L55.65 36.3 Q5'
  + '4.45 43.55 49 49 41.95 56 32 56 22 56 15.05 49 8 41.95 8 32 8 22 15.05 15.05 22 8 32 8 M46.85 17.15 Q40.7 11 32 11 23.25 11 17.1'
  + '5 17.15 11 23.25 11 32 11 40.7 17.15 46.85 23.25 53 32 53 40.7 53 46.85 46.85 53 40.7 53 32 53 23.25 46.85 17.15"/>'
  + '  </g>'
  + '</svg>'
;
SVGInputPrompts[CSVGSteamDpadUpOutline] := 
  '<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">'
  + '  <defs/>'
  + '  <g>'
  + '    <path stroke="none" fill="#FFFFFF" d="M46.85 17.15 Q40.75 11 32 11 23.3 11 17.15 17.15 11 23.3 11 32 11 40.75 17.15 46.85 23'
  + '.3 53 32 53 40.75 53 46.85 46.85 53 40.75 53 32 53 23.3 46.85 17.15 M56 32 Q56 42 48.95 48.95 42 56 32 56 22.05 56 15 48.95 8 42'
  + ' 8 32 8 22.05 15 15 20.45 9.55 27.7 8.35 L32 8 36.35 8.35 Q43.55 9.55 48.95 15 56 22.05 56 32 M36 28 L44 28 Q45.65 28 46.85 29.1'
  + '5 48 30.35 48 32 48 33.65 46.85 34.8 45.65 36 44 36 L36 36 36 44 Q36 45.65 34.8 46.8 33.65 48 32 48 30.35 48 29.15 46.8 28 45.65'
  + ' 28 44 L28 36 20 36 Q18.35 36 17.2 34.8 16 33.65 16 32 16 30.35 17.2 29.15 18.35 28 20 28 L28 28 36 28"/>'
  + '    <path stroke="none" fill="#E73246" d="M36 28 L28 28 28 20 Q28 18.35 29.15 17.15 30.35 16 32 16 33.65 16 34.8 17.15 36 18.35 '
  + '36 20 L36 28"/>'
  + '  </g>'
  + '</svg>'
;

RegisterSVGBitmap;

end.
