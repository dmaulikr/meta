//
//  Configuration.h
//  Meta
//
//  Created by Matěj Sychra on 30/1/15.
//  Copyright (c) 2015 T-Mobile Czech Republic a.s. All rights reserved.
//

// Universe
#define MAX_UNIVERSE_DIMENSIONS 10

// Dimension
#define MAX_DIMENSION_AGE 20 // seconds
#define MAX_DIMENSION_GODS 10

// Gods
#define DEBUG_NEW_GODS
#define MAX_GOD_GENDER_COUNT 2

// Living Entities
typedef enum {
    It = 0,
    She = 1,
    He = 2
} Gender;

#define MAX_ENTITY_ENDURANCE 300


