#!/usr/bin/env python3
""" This is bitcoin price vs rate of change web app"""

import base64
import datetime
import streamlit as st
import pandas as pd
from PIL import Image
import yfinance as yf

# Page layout
# Page expands to full width
st.set_page_config(layout="wide")
# ---------------------------------#
# Title

IMAGE = Image.open('logo.jpg')

st.image(IMAGE, width=500)

st.title('Price vs ROC App')
st.markdown("""
This app retrieves cryptocurrency prices from **Yahoo Finance** and calculates the Rate of Change!
""")
# ---------------------------------#
# About
EXPANDER_BAR = st.beta_expander("About")
EXPANDER_BAR.markdown("""
* **Python libraries:** base64, pandas, streamlit, yfinance, numpy, matplotlib, seaborn, BeautifulSoup, requests, json, time
* **Data source:** [Yahoo Finance](http://finance.yahoo.com).
* **Credit:** Investing with Python: Rate of Change *[Investing with Python: Rate of Change](http://www.andrewshamlet.net/2017/07/07/python-tutorial-roc/)*.
""")

# ---------------------------------#
# Page layout (continued)
# Divide page to 3 columns (col1 = sidebar, col2 and col3 = page contents)
COL1 = st.sidebar
COL2, COL3 = st.beta_columns((2, 1))

# ---------------------------------#
# Sidebar + Main panel
COL1.header('Input Options')

# Sidebar - Currency price unit
CURRENCY_PRICE_UNIT = COL1.selectbox('Select currency', ('SNT-USD', 'BTC-USD', 'ETH-USD', 'LTC-USD'))
ROC_PERIOD = COL1.selectbox('Select ROC period', (15, 25, 50, 100, 200))
START_DATE = COL1.date_input("Start date", datetime.date(2010, 1, 1))
END_DATE = COL1.date_input("End date", datetime.datetime.now())


@st.cache
def get_crypto(crypto, period, start, end):
    """ This function gets the history price date from yahoo."""
    ticker_data = yf.Ticker(crypto)
    return ticker_data.history(period=period, start=start, end=end)['Close']


def roc(dataframe, period):
    """ This function calculates rate of change for an asset in period n"""
    difference = dataframe.diff(period - 1)
    old_price = dataframe.shift(period - 1)
    result = pd.Series(((difference / old_price) * 100), name='ROC_' + str(old_price))
    return result


DF = pd.DataFrame(get_crypto(CURRENCY_PRICE_UNIT, '1d', START_DATE, END_DATE))
DF['ROC'] = roc(DF['Close'], ROC_PERIOD)
DF.tail()

st.write("""
## Closing Price and ROC

***
""")
st.line_chart(DF['Close'])
st.line_chart(DF['ROC'])


# Download CSV data
# https://discuss.streamlit.io/t/how-to-download-file-in-streamlit/1806
def filedownload(dataframe):
    """ This puts the close price and rate of change in csv file and creates download URL"""
    csv = dataframe.to_csv(index=True)
    b64 = base64.b64encode(csv.encode()).decode()  # strings <-> bytes conversions
    href = f'<a href="data:file/csv;base64,{b64}" download="crypto.csv">Download CSV File</a>'
    return href


st.write(filedownload(DF), unsafe_allow_html=True)
