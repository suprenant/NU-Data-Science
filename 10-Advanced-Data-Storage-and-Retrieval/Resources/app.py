import numpy as np
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func
from flask import Flask, jsonify
import datetime as dt
from datetime import timedelta 

## Database setup
engine = create_engine("sqlite:///hawaii.sqlite")

# Reflect existing database into a new model
Base = automap_base()
# Reflect tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Passenger = Base.classes.passenger

## Flask setup
app = Flask(__name__)

## Flask routes

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"        
        f"/api/v1.0/<start><br/>" 
        f"/api/v1.0/<start>/<end>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    # Create session (link) from Python to database
    session = Session(engine)

    # Query to retrieve data and precipitation scores
    prev_year = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    results = session.query(measurement.date, measurement.prcp).filter(measurement.date >= prev_year).all()

    session.close()

    precip = {date: prcp for date, prcp in results}
    return jsonify(precip)

@app.route("/api/v1.0/stations")
def passengers():
    session = Session(engine)

    #Return JSON list of stations from the dataset
    results = session.query(station.station).all()

    session.close()

    stations = list(np.ravel(results))
    return jsonify(stations)

@app.route("/api/v1.0/tobs")
def passengers():
    session = Session(engine)

    #Query for dates and temperature observations from a year from the last data point
    results = session.query(measurement.date, measurement.tobs).filter(measurement.date>=prev_year).all()

    session.close()

    #Return a JSON list of temperature observations for the previous year
    tobs = list(np.ravel(results))
    return jsonify(tobs)    

@app.route("/api/v1.0/<start><br/>")
def passengers():
    session = Session(engine)

    #TO-DO: NEED TO FILTER
    #Return JSON list of minimum temperature, average temperature, and max temperature for a given start or start-end range
    results = session.query(func.min(measurement.tobs), func.max(measurement.tobs), func.avg(measurement.tobs)).all()

    #TO-DO: CONFIG FOR GIVEN START ONLY
    #When given the start only, calculate TMIN, TAVG, and TMAX for all dates greater than and equal to the start date.

    session.close()

    tobs = list(np.ravel(results))
    return jsonify(tobs)

@app.route("/api/v1.0/<start>/<end>")
def passengers():
    session = Session(engine)

    #TO-DO: CONFIG FOR START/END GIVEN
    #When given the start and the end date, calculate the TMIN, TAVG, and TMAX for dates between the start and end date inclusive.    
    results = session.query(station.station).all()

    session.close()

    tobs = list(np.ravel(results))
    return jsonify(tobs)

if __name__ == '__main__':
    app.run(debug=True)