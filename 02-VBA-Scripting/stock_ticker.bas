Attribute VB_Name = "Module1"
Sub stock_ticker()

  'Set an initial variable to hold the stock ticker symbol
  Dim ticker As String
  
  '[BREAKS IF Integer for some reason] Set variable for volume
  Dim volume As Double

  'Set variable for year open
  Dim year_open As Double

  'Set variable for year close
  Dim year_close As Double
  
  'Set variable for yearly change
  Dim yearly_change As Double

  'Set variable for percent change
  Dim percent_change As Double
  
  'Set...the other variables
  Dim i, j As Integer
  Dim summary_table_row As Integer
  
  For Each ws In Worksheets
  
    'Label the worksheet columns
    ws.Cells(1, 9).Value = "Ticker symbol"
    ws.Cells(1, 10).Value = "Yearly change ($)"
    ws.Cells(1, 11).Value = "Percent change"
    ws.Cells(1, 12).Value = "Total stock volume"
    
    'Display change column as percentage and volume column as integer
    Columns("K").NumberFormat = "0.00%"
    Columns("L").NumberFormat = "0"

    'Keep track of the location for each stock ticker symbol
    summary_table_row = 2
   
    'Determine the Last Row
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    'Loop through all stock ticker symbols
    For i = 2 To LastRow
  
        'Check to see if we are seeing a different symbol between rows
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
       
        'Set the ticker symbol name
        ticker = ws.Cells(i, 1).Value
    
        'Find the volume
        volume = ws.Cells(i, 7).Value
       
        '[ASSUMES ALL STOCKS HAVE 262 entries] Find the year open
        year_open = ws.Cells(i - 260, 3).Value
       
        'Find the year close
        year_close = ws.Cells(i, 6).Value
       
        'Calculate the yearly change
        yearly_change = year_close - year_open
        
            'Handle zeros
            If yearly_open = 0 Then
        
            'Print the ticker symbol, yearly change, percent change, and volume (volume as 0)
             ws.Cells(summary_table_row, 9).Value = ticker
             ws.Cells(summary_table_row, 10).Value = yearly_change
             ws.Cells(summary_table_row, 11).Value = "%" & 0
             ws.Cells(summary_table_row, 12).Value = volume
        
            Else
                
             'Calculate the percent change (from the opening price)
             percent_change = yearly_change / year_open
            
             'Print the ticker symbol, yearly change, percent change, and volume (volume as actual volume)
             ws.Cells(summary_table_row, 9).Value = ticker
             ws.Cells(summary_table_row, 10).Value = yearly_change
             ws.Cells(summary_table_row, 11).Value = percent_change
             ws.Cells(summary_table_row, 12).Value = volume
       
            End If
       
       'Add one to the summary table row
       summary_table_row = summary_table_row + 1
       
       'If the cell immediately following a row is the same ticker symbol
       Else
    
       End If
   
 Next i
 
  'Contitional formatting

   'Loop through each row of the board
    For i = 2 To LastRow

    'Loop through the yearly change and percentage columns
    For j = 10 To 11

      'Color positive values green
      If ws.Cells(i, j).Value > 0 Then
        ws.Cells(i, j).Interior.ColorIndex = 4

     'Color negative values red
     ElseIf ws.Cells(i, j).Value < 0 Then
        ws.Cells(i, j).Interior.ColorIndex = 3
        
     'Color zeros white
     ElseIf ws.Cells(i, j).Value = 0 Then
        ws.Cells(i, j).Interior.ColorIndex = 2
 
    End If

    Next j

  Next i
  
Next ws

End Sub

