unit USVGUIPack;

// ****************************************
// * SVG from folder :
// * C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\gfgsk\assets\kenney_nl\UIPack\USVGUIPack.pas
// ****************************************
//
// This file contains a list of contants and 
// an enumeration to access to SVG source codes 
// from the generated array of strings.
//
// ****************************************
// File generator : SVG Folder to Delphi Unit v1.0
// Website : https://svgfolder2delphiunit.olfsoftware.fr/
// Generation date : 2024-08-21T10:30:39.111Z
//
// Don't do any change on this file.
// They will be erased by next generation !
// ****************************************

interface

const
  CSVGButtonRectangleDepthBorder = 0;
  CSVGButtonRectangleDepthLine = 1;
  CSVGButtonRectangleFlat = 2;
  CSVGButtonRectangleLine = 3;

type
{$SCOPEDENUMS ON}
  TSVGUIPackIndex = (
    ButtonRectangleDepthBorder = CSVGButtonRectangleDepthBorder,
    ButtonRectangleDepthLine = CSVGButtonRectangleDepthLine,
    ButtonRectangleFlat = CSVGButtonRectangleFlat,
    ButtonRectangleLine = CSVGButtonRectangleLine);

  TSVGUIPack = class
  private
  class var
    FTag: integer;
    FTagBool: Boolean;
    FTagFloat: Single;
    FTagObject: TObject;
    FTagString: string;
    class procedure SetTag(const Value: integer); static;
    class procedure SetTagBool(const Value: Boolean); static;
    class procedure SetTagFloat(const Value: Single); static;
    class procedure SetTagObject(const Value: TObject); static;
    class procedure SetTagString(const Value: string); static;
  public const
    ButtonRectangleDepthBorder = CSVGButtonRectangleDepthBorder;
    ButtonRectangleDepthLine = CSVGButtonRectangleDepthLine;
    ButtonRectangleFlat = CSVGButtonRectangleFlat;
    ButtonRectangleLine = CSVGButtonRectangleLine;
    class property Tag: integer read FTag write SetTag;
    class property TagBool: Boolean read FTagBool write SetTagBool;
    class property TagFloat: Single read FTagFloat write SetTagFloat;
    class property TagObject: TObject read FTagObject write SetTagObject;
    class property TagString: string read FTagString write SetTagString;
    class function SVG(const Index: Integer): string; overload;
    class function SVG(const Index: TSVGUIPackIndex) : string; overload;
    class function Count : Integer;
    class constructor Create;
  end;

var
  SVGUIPack : array of String;

implementation

uses
  System.SysUtils;

{ TSVGUIPack }

class constructor TSVGUIPack.Create;
begin
  inherited;
  FTag := 0;
  FTagBool := false;
  FTagFloat := 0;
  FTagObject := nil;
  FTagString := '';
end;

class procedure TSVGUIPack.SetTag(const Value: integer);
begin
  FTag := Value;
end;

class procedure TSVGUIPack.SetTagBool(const Value: Boolean);
begin
  FTagBool := Value;
end;

class procedure TSVGUIPack.SetTagFloat(const Value: Single);
begin
  FTagFloat := Value;
end;

class procedure TSVGUIPack.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

class procedure TSVGUIPack.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

class function TSVGUIPack.SVG(const Index: Integer): string;
begin
  if (index < Count) then
    result := SVGUIPack[index]
  else
    raise Exception.Create('SVG not found. Index out of range.');
end;

class function TSVGUIPack.SVG(const Index : TSVGUIPackIndex): string;
begin
  result := SVG(ord(index));
end;

class function TSVGUIPack.Count: Integer;
begin
  result := length(SVGUIPack);
end;

initialization

SetLength(SVGUIPack, 4);

{$TEXTBLOCK NATIVE XML}
SVGUIPack[CSVGButtonRectangleDepthBorder] := '''
<svg width="192" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#167DA8" d="M189.95 25.2 L189.95 24.8 190 24 190 6 189.95 5.05 Q189.5 2 186 2 L6 2 Q2.5 2 2.1 5.05 L2 6 2 24 2.05 24.8 2.05 25.2 2 26 2 54 Q2 58 6 58 L186 58 Q190 58 190 54 L190 26 189.95 25.2 M0 24.75 L0 6 Q0 0 6 0 L186 0 Q192 0 192 6 L192 24.75 191.95 25 192 25.4 192 54.25 Q191.85 60 186 60 L6 60 Q0.15 60 0 54.25 L0 25.4 0.05 25 0 24.75"/>
    <path stroke="none" fill="#36BDF7" d="M189.95 25.2 L190 26 190 54 Q190 58 186 58 L6 58 Q2 58 2 54 L2 26 2.05 25.2 2.05 24.8 2 24 2 6 2.1 5.05 Q2.5 2 6 2 L186 2 Q189.5 2 189.95 5.05 L190 6 190 24 189.95 24.8 189.95 25.2 M6 4 Q4.35 4 4.1 5.3 L4.05 5.5 4 6 4 24 4.05 24.55 4.05 24.8 4.05 25.2 4.05 25.45 4 26 4 54 Q4 56 6 56 L186 56 Q188 56 188 54 L188 26 188 25.45 187.95 25.2 187.95 24.8 188 24.55 188 24 188 6 187.95 5.3 188 5.35 Q187.65 4 186 4 L6 4"/>
    <path stroke="none" fill="#1C9FD7" d="M6 4 L186 4 Q187.65 4 188 5.35 L187.95 5.3 188 6 188 24 188 24.55 187.95 24.8 187.95 25.2 188 25.45 188 26 188 54 Q188 56 186 56 L6 56 Q4 56 4 54 L4 26 4.05 25.45 4.05 25.2 4.05 24.8 4.05 24.55 4 24 4 6 4.05 5.5 4.1 5.3 Q4.35 4 6 4 M84.7 6 L81.8 6 6 6 6 24 6 24.15 6.05 24.55 6.05 24.8 6.05 25.2 6.05 25.45 6.05 25.8 6 26 6 54 81.8 54 87.55 54 186 54 186 26 186 25.75 185.95 25.2 185.95 24.8 186 24.3 186 24 186 6 84.7 6"/>
    <path stroke="none" fill="#FFFFFF" d="M84.7 6 L186 6 186 24 186 24.3 185.95 24.8 185.95 25.2 186 25.75 186 26 186 54 87.55 54 81.8 54 6 54 6 26 6.05 25.8 6.05 25.45 6.05 25.2 6.05 24.8 6.05 24.55 6 24.15 6 24 6 6 81.8 6 84.7 6 M183.95 25.05 L183.95 24.95 Q183.9 24.55 184 24.1 L184 24 184 8 8 8 8 24 8.05 24.5 8.05 24.55 8.05 24.8 8.05 25.2 8.05 25.45 8 26.1 8 52 184 52 184 26 184 25.9 183.95 25.05"/>
    <path stroke="none" fill="#DADCE7" d="M183.95 25.05 L184 25.9 184 26 184 52 8 52 8 26.1 8.05 25.45 8.05 25.2 8.05 24.8 8.05 24.55 8.05 24.5 8 24 8 8 184 8 184 24 184 24.1 Q183.9 24.55 183.95 24.95 L183.95 25.05"/>
    <path stroke="none" fill="#FF0000" d="M192 24.75 L192 25.4 191.95 25 192 24.75 M0 25.4 L0 24.75 0.05 25 0 25.4"/>
    <path stroke="none" fill="#146587" d="M192 54.25 L192 58 Q192 64 186 64 L6 64 Q0 64 0 58 L0 54.25 Q0.15 60 6 60 L186 60 Q191.85 60 192 54.25"/>
  </g>
</svg>
''';
SVGUIPack[CSVGButtonRectangleDepthLine] := '''
<svg width="192" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#9696A3" d="M0 24.75 L0 6 Q0 0 6 0 L186 0 Q192 0 192 6 L192 24.75 191.95 25 192 25.4 192 54.25 Q191.85 60 186 60 L6 60 Q0.15 60 0 54.25 L0 25.4 0.05 25 0 24.75 M189.95 25.2 L189.95 24.8 190 24 190 6 189.95 5.05 Q189.5 2 186 2 L6 2 Q2.5 2 2.1 5.05 L2 6 2 24 2.05 24.8 2.05 25.2 2 26 2 54 Q2 58 6 58 L186 58 Q190 58 190 54 L190 26 189.95 25.2"/>
    <path stroke="none" fill="#FFFFFF" d="M189.95 25.2 L190 26 190 54 Q190 58 186 58 L6 58 Q2 58 2 54 L2 26 2.05 25.2 2.05 24.8 2 24 2 6 2.1 5.05 Q2.5 2 6 2 L186 2 Q189.5 2 189.95 5.05 L190 6 190 24 189.95 24.8 189.95 25.2 M6 4 Q4.35 4 4.1 5.3 L4.05 5.5 4 6 4 24 4.05 24.55 4.05 24.8 4.05 25.2 4.05 25.45 4 26 4 54 Q4 56 6 56 L186 56 Q188 56 188 54 L188 26 188 25.45 187.95 25.2 187.95 24.8 188 24.55 188 24 188 6 187.95 5.3 188 5.35 Q187.65 4 186 4 L6 4"/>
    <path stroke="none" fill="#DADCE7" d="M6 4 L186 4 Q187.65 4 188 5.35 L187.95 5.3 188 6 188 24 188 24.55 187.95 24.8 187.95 25.2 188 25.45 188 26 188 54 Q188 56 186 56 L6 56 Q4 56 4 54 L4 26 4.05 25.45 4.05 25.2 4.05 24.8 4.05 24.55 4 24 4 6 4.05 5.5 4.1 5.3 Q4.35 4 6 4 M84.7 6 L81.8 6 6 6 6 24 6 24.15 6.05 24.55 6.05 24.8 6.05 25.2 6.05 25.45 6.05 25.8 6 26 6 54 81.8 54 87.55 54 186 54 186 26 186 25.75 185.95 25.2 185.95 24.8 186 24.3 186 24 186 6 84.7 6 M183.95 25.05 L184 25.9 184 26 184 52 8 52 8 26.1 8.05 25.45 8.05 25.2 8.05 24.8 8.05 24.55 8.05 24.5 8 24 8 8 184 8 184 24 184 24.1 Q183.9 24.55 183.95 24.95 L183.95 25.05"/>
    <path stroke="none" fill="#36BDF7" d="M183.95 25.05 L183.95 24.95 Q183.9 24.55 184 24.1 L184 24 184 8 8 8 8 24 8.05 24.5 8.05 24.55 8.05 24.8 8.05 25.2 8.05 25.45 8 26.1 8 52 184 52 184 26 184 25.9 183.95 25.05 M84.7 6 L186 6 186 24 186 24.3 185.95 24.8 185.95 25.2 186 25.75 186 26 186 54 87.55 54 81.8 54 6 54 6 26 6.05 25.8 6.05 25.45 6.05 25.2 6.05 24.8 6.05 24.55 6 24.15 6 24 6 6 81.8 6 84.7 6"/>
    <path stroke="none" fill="#FF0000" d="M192 24.75 L192 25.4 191.95 25 192 24.75 M0 25.4 L0 24.75 0.05 25 0 25.4"/>
    <path stroke="none" fill="#747487" d="M192 54.25 L192 58 Q192 64 186 64 L6 64 Q0 64 0 58 L0 54.25 Q0.15 60 6 60 L186 60 Q191.85 60 192 54.25"/>
  </g>
</svg>
''';
SVGUIPack[CSVGButtonRectangleFlat] := '''
<svg width="192" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#989AAF" d="M0 58.25 L0 5.95 Q0.05 0 6 0 L186 0 Q192 0 192 5.95 L192 58.25 Q191.85 64 186 64 L6 64 Q0.15 64 0 58.25 M186.5 2.05 L6 2 5.9 2 5.4 2.05 Q2 2.3 2 5.95 L2 58 Q2 62 6 62 L186 62 Q190 62 190 58 L190 5.95 Q190 2.25 186.5 2.05"/>
    <path stroke="none" fill="#FFFFFF" d="M186.5 2.05 Q190 2.25 190 5.95 L190 58 Q190 62 186 62 L6 62 Q2 62 2 58 L2 5.95 Q2 2.3 5.4 2.05 L5.9 2 6 2 186.5 2.05 M186.4 4.05 L6.1 4 5.6 4.05 5.55 4.05 Q4 4.2 4 5.95 L4 58 Q4 60 6 60 L186 60 Q188 60 188 58 L188 5.95 Q188 4.2 186.4 4.05"/>
    <path stroke="none" fill="#DADCE7" d="M186.4 4.05 Q188 4.2 188 5.95 L188 58 Q188 60 186 60 L6 60 Q4 60 4 58 L4 5.95 Q4 4.2 5.55 4.05 L5.6 4.05 6.1 4 186.4 4.05"/>
  </g>
</svg>
''';
SVGUIPack[CSVGButtonRectangleLine] := '''
<svg width="192" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#9696A3" d="M0 58.25 L0 5.95 Q0.05 0 6 0 L186 0 Q192 0 192 5.95 L192 58.25 Q191.85 64 186 64 L6 64 Q0.15 64 0 58.25 M186.5 2.05 L6 2 5.9 2 5.4 2.05 Q2 2.3 2 5.95 L2 58 Q2 62 6 62 L186 62 Q190 62 190 58 L190 5.95 Q190 2.25 186.5 2.05"/>
    <path stroke="none" fill="#FFFFFF" d="M186.5 2.05 Q190 2.25 190 5.95 L190 58 Q190 62 186 62 L6 62 Q2 62 2 58 L2 5.95 Q2 2.3 5.4 2.05 L5.9 2 6 2 186.5 2.05 M186.4 4.05 L6.1 4 5.6 4.05 5.55 4.05 Q4 4.2 4 5.95 L4 58 Q4 60 6 60 L186 60 Q188 60 188 58 L188 5.95 Q188 4.2 186.4 4.05"/>
    <path stroke="none" fill="#DADCE7" d="M186.4 4.05 Q188 4.2 188 5.95 L188 58 Q188 60 186 60 L6 60 Q4 60 4 58 L4 5.95 Q4 4.2 5.55 4.05 L5.6 4.05 6.1 4 186.4 4.05 M6.3 6 L6 6.05 6 58 186 58 186 6.05 6.3 6 M184 8.05 L184 56 8 56 8 8 184 8.05"/>
    <path stroke="none" fill="#36BDF7" d="M184 8.05 L8 8 8 56 184 56 184 8.05 M6.3 6 L186 6.05 186 58 6 58 6 6.05 6.3 6"/>
  </g>
</svg>
''';

end.
