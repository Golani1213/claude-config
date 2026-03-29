# Finance Rules

## Precision
- Never round intermediate calculations — carry full precision, round only final output
- Always show calculation steps, not just answers
- Currency: always state which (EUR/USD) — never assume
- Percentages: clarify if absolute (5%) or relative (5% of 5% = 0.25%)

## Dutch Tax Context
- Box 3 vermogensbelasting: use current peildatum (Jan 1) and actual return categories (savings, investments, other)
- Jaarruimte/reserveringsruimte: apply correct year's formula — these change annually
- When calculating tax: state which year's rates you're using and flag if knowledge might be outdated

## Trading / Portfolio
- IB data: read-only — never modify export files
- Options: always state assumptions (European vs American, dividend-adjusted, implied vol source)
- P&L: distinguish realized vs unrealized, include transaction costs
- FX: state the rate and timestamp when converting

## CFA
- When explaining concepts: use CFA Institute terminology and notation
- Practice problems: don't reveal the answer until asked — guide through the logic
- Formulas: show the general form first, then substitute values

## Data Handling
- Excel/CSV from IB or broker: always create a copy before processing
- DuckDB for analysis — never pandas on the original file
- Date formats: assume DD-MM-YYYY (Dutch) unless the file clearly uses MM-DD-YYYY
