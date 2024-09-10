CREATE TABLE category (
    CID INT PRIMARY KEY,  -- Primary key
    Name VARCHAR(255) NOT NULL  -- Category name
);
INSERT INTO category (CID, Name) VALUES (1, 'Price');
INSERT INTO category (CID, Name) VALUES (2, 'Cleanliness');
INSERT INTO category (CID, Name) VALUES (3, 'Location');

commit;

CREATE TABLE seed (
    SID INT PRIMARY KEY,
    CID INT,
    review VARCHAR2(100),
    value INT,
    CONSTRAINT fk_category
        FOREIGN KEY (CID)
        REFERENCES category(CID)
);

COMMIT;

