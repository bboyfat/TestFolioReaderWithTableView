//
//  TableViewController.swift
//  ReadBooks
//
//  Created by Andrey Petrovskiy on 03.12.2018.
//  Copyright © 2018 Andrey Petrovskiy. All rights reserved.
//

import UIKit

import FolioReaderKit

class TableViewController: UITableViewController {
    
    var bookGenre = ["Фэнтези", "Роман","Детектив"]
    var bookAuthor = ["Льюис Кэрролл", "Герман Мелвилл", "Артур Конан Дойл"]
    var booksName = ["\"Алиса в стране чудес\"", "\"Моби-Дик\"","\"Записки о Шерлоке Холмсе\""]
    var bookDetails = [Epub.bookOne, Epub.bookTwo, Epub.bookThree]
    let folioReader = FolioReader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
       

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookDetails.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BooksTableViewCell
        
        cell.bookName?.numberOfLines = 0
        cell.bookName?.lineBreakMode = .byWordWrapping
        
        
        
        
        let epub = Epub(rawValue: bookDetails[indexPath.row].rawValue)
        let bookPath = epub!.bookPath
        
       
        
        do {
            let image = try FolioReader.getCoverImage(bookPath!)
            cell.bookImage!.image = image
        } catch {
            print(error.localizedDescription)
        }
        cell.bookGenre.text = bookGenre[indexPath.row]
        cell.bookAuthor.text = bookAuthor[indexPath.row]
        cell.bookName.text = booksName[indexPath.row]
        cell.bookImage.clipsToBounds = true
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let epub = Epub(rawValue: bookDetails[indexPath.row].rawValue) else {return}
        
        self.open(epub: epub)
        
    }

    private func readerConfiguration (forEpub epub: Epub) -> FolioReaderConfig{
        let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
        config.shouldHideNavigationOnTap = epub.shouldHiddenNavigationOnTap
        config.scrollDirection = epub.scrollDirection
        
        config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "moby") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }
        
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)
        
        return config
    }
    
    fileprivate func open (epub: Epub){
        
        guard let bookPath = epub.bookPath else {
            return
        }
        
        let readerConfiguration = self.readerConfiguration(forEpub: epub)
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

