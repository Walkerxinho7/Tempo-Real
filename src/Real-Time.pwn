/*
 * Real-Time Filterscript for SA-MP (San Andreas Multiplayer)
 * Copyright (c) Calasans
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

#define FILTERSCRIPT

#include <a_samp>

#define TRF_UPDATE_INTERVAL  (5*1000)
#define TRF_DAWN_TIME        (5)
#define TRF_MORNING_TIME     (7)
#define TRF_NOON_TIME        (12)
#define TRF_EVENING_TIME     (20)
#define TRF_NIGHT_TIME       (0)

static TRF_Last_WorldTime = -1;

public OnFilterScriptInit() {
    print("");
    print("__________________________________________________________________");
    print("||==============================================================||");
    print("||                                                              ||");
    print("||                    Real-Time Filterscript                    ||");
    print("||                                                              ||");
    print("|| Developer: Calasans                                          ||");
    print("|| Instagram: ocalasans                                         ||");
    print("|| Discord: ocalasans                                           ||");
    print("||                                                              ||");
    print("||==============================================================||");
    print("__________________________________________________________________");
    print("");

    SetTimer("TRF_UpdateWorldTime", TRF_UPDATE_INTERVAL, true);

    return 1;
}

public OnFilterScriptExit()
    return true;

forward TRF_UpdateWorldTime();
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;

    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    new TRF_New_WorldTime;
    
    if(TRF_Current_Hour >= 0 && TRF_Current_Hour <= 5)
        TRF_New_WorldTime = TRF_DAWN_TIME;
    
    else if(TRF_Current_Hour >= 6 && TRF_Current_Hour <= 10)
        TRF_New_WorldTime = TRF_MORNING_TIME;
    
    else if(TRF_Current_Hour >= 11 && TRF_Current_Hour <= 15)
        TRF_New_WorldTime = TRF_NOON_TIME;
    
    else if(TRF_Current_Hour >= 16 && TRF_Current_Hour <= 17)
        TRF_New_WorldTime = TRF_EVENING_TIME;
    else
        TRF_New_WorldTime = TRF_NIGHT_TIME;
    
    if(TRF_New_WorldTime != TRF_Last_WorldTime) {
        SetWorldTime(TRF_New_WorldTime);

        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
    
    return true;
}
