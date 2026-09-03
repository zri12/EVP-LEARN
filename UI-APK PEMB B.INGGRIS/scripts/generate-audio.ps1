Add-Type -AssemblyName System.Speech

$audioRoot = Join-Path $PSScriptRoot "..\public\audio"
$vocabRoot = Join-Path $audioRoot "vocabulary"
$glossaryRoot = Join-Path $audioRoot "glossary"
$readingRoot = Join-Path $audioRoot "reading"
New-Item -ItemType Directory -Force -Path $vocabRoot, $glossaryRoot, $readingRoot | Out-Null

$voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
$voice.Rate = -1
$voice.Volume = 100

function Save-Speech([string]$Path, [string]$Text) {
  $voice.SetOutputToWaveFile($Path)
  $voice.Speak($Text)
  $voice.SetOutputToNull()
}

$vocabulary = @{
  1 = @("Founder", "Venture", "Crisis", "Breakthrough", "Retailer", "Boycott", "Delivery", "Revolutionary", "Flat packing", "Assemble")
  2 = @("Merchandise", "Durable", "Adjustable", "Display", "Sleek", "Casing", "Dual screen display", "Integrated", "Sturdy", "Finish", "Gondola shelving", "Open front", "Visibility", "Premium", "Asymmetrical", "Eye catching", "Centerpiece")
  3 = @("Scan", "Receipt", "Checkout", "Verify", "Cash drawer", "Greet", "Payment method", "Insert", "Attach")
}

foreach ($module in $vocabulary.Keys) {
  for ($index = 0; $index -lt $vocabulary[$module].Count; $index++) {
    Save-Speech (Join-Path $vocabRoot "m$module-$($index + 1).wav") $vocabulary[$module][$index]
  }
}

$glossary = @(
  "Affordable", "Supplier", "Suppliers", "Crisis", "Delivery", "Flat pack", "Flat-packing", "Assemble", "Innovation", "Boycott", "Revolutionary",
  "Retailer", "Merchandise", "Display", "Sleek", "Casing", "Dual screen display", "Integrated", "Sturdy", "Finish", "Gondola shelving", "Adjustable", "Durable", "Open front", "Visibility", "Premium", "Genuine", "Asymmetrical", "Eye catching", "Centerpiece", "Checkout", "Greet", "Scan", "Verify", "Payment method", "Insert", "Cash drawer", "Receipt", "Attach"
)

foreach ($word in $glossary) {
  $fileName = $word.ToLower().Replace(" ", "-")
  Save-Speech (Join-Path $glossaryRoot "$fileName.wav") $word
}

$reading = @{
  "m1-1" = "The Story of IKEA. Long ago in 1943, a 17-year-old boy named Ingvar Kamprad founded a small business in Almhult, Sweden. He wanted to create affordable furniture that ordinary people could buy and enjoy in their homes. As IKEA grew, its suppliers faced a boycott from competitors. Delivery of goods became difficult and expensive. The company needed a revolutionary way to solve its supply and cost problems. IKEA developed the flat-pack concept, furniture packed flat in boxes so customers could carry it home easily and assemble it themselves. This innovation reduced shipping costs and changed the furniture retailer industry forever. Today, IKEA operates in more than 50 countries and serves millions of customers worldwide. Its story is a powerful example of innovation and the spirit of making great design accessible to everyone."
  "m2-1" = "Modern Touchscreen POS Terminal. The Modern Touchscreen POS Terminal is a high-performance point-of-sale device designed specifically for busy retail environments. It features a sleek aluminum casing with a dual-screen display. One screen faces the cashier and one faces the customer. The system has an integrated barcode scanner, receipt printer, and card payment reader. Its sturdy construction ensures it can withstand daily use in demanding retail settings. The matte black finish gives it a professional and modern appearance."
  "m2-2" = "Heavy-Duty Supermarket Gondola Shelving. The Heavy-Duty Supermarket Gondola Shelving is a commercial-grade retail fixture widely used in supermarkets, convenience stores, and hypermarkets. Each unit consists of a steel frame with adjustable shelves that can be repositioned at different heights. The shelving is made from durable powder-coated steel that resists rust and damage. Its open-front design allows customers to see and reach products easily, maximizing product visibility and encouraging purchases."
  "m2-3" = "Vintage Leather Biker Jacket. The Urban Rider Jacket is a premium vintage-style leather biker jacket designed for fashion-forward retail display and customer appeal. The jacket is crafted from full-grain genuine leather with a classic asymmetrical zip closure. It features wide lapels, two front zippered pockets, and a quilted inner lining for comfort. The distressed finish gives it an authentic vintage character. This jacket is a key display piece for fashion retail stores targeting young adult customers."
  "m3-1" = "How to Process Customer Checkout Using a POS Terminal. Goal. To process a customer's purchase accurately and efficiently using a POS terminal, ensuring a smooth checkout experience. Materials and equipment. POS terminal with touchscreen display, barcode scanner, receipt printer, card payment reader, cash drawer, price tags and product barcodes. Steps. First, welcome the customer warmly as they approach the counter. Next, scan each product's barcode using the barcode scanner. Then, confirm the product name and price on the POS screen with the customer. Ask the customer whether they will pay by cash or card. For card payment, insert or tap the card on the EDC machine. For cash, enter the amount received. Finally, print the receipt, attach it to the bag if applicable, and hand it over to the customer with a thank-you."
}

foreach ($key in $reading.Keys) {
  Save-Speech (Join-Path $readingRoot "$key.wav") $reading[$key]
}

$voice.Dispose()
