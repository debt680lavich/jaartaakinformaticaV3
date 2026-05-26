using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace Aanmelden
{
    public class Variables
    {
        //admin Overzicht verhuringen
        
        public static DataRow dtRijVERHUUR;
        
        //Verhuring
        public static DataTable dtblBestelling = new DataTable();
        public static DataRow dtRij;
        public static string geselecteerdArtikel;
        public static int aantalrijen;
        public static decimal totaalbrutobedrag;


        public static bool paginaterug;

        public static int verhuurID;

        public static string leverenophalen;
        public static string begindatum;
        public static string einddatum;
        public static string tijd;
       
        public static string straat;
        public static string huisnummer;
        public static string postcode;
        public static string gemeente;

        public static string Naam;
        public static string Achternaam;
        public static string email;
        public static string telefoonnr;

        public static string betaalwijze;

        //aanmelden
        public static bool aangemeld;
        public static bool adminaangemeld;
    }
}