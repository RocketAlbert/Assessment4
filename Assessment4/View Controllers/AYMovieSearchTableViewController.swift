//
//  AYMovieSearchTableViewController.swift
//  Assessment4
//
//  Created by Albert Yu on 7/5/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit

class AYMovieSearchTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [AYMovie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? AYTableViewCell else {return UITableViewCell ()}
        let movie = movies[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.movieRating.text = movie.rating?.stringValue
        cell.movieOverview.text = movie.overview
        AYMovieController.sharedInstance().fetchPoster(movie) { (movieImage) in
            if movieImage != nil {
                DispatchQueue.main.async {
                    cell.moviePosterImageView.image = movieImage
                }
            } else {
                cell.moviePosterImageView.image = nil
            }
        }
        return cell
    }
}


extension AYMovieSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else {return}
        AYMovieController.sharedInstance().fetchMovies(searchTerm) { (moviesFromCompletion) in
            if (!moviesFromCompletion.isEmpty) {
                self.movies = moviesFromCompletion
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {return}
        }
    }
}
